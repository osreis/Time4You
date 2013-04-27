class OrdersController < ApplicationController
  before_filter :authorize
	
  def index
	if !params[:order_date]
		@orders = Order.paginate(:page => params[:page], :per_page => 10).order('id DESC')
	else
		date = Date.new(params[:order_date][:year].to_i,params[:order_date][:month].to_i,params[:order_date][:day].to_i)  
		@orders = Order.where(created: date).paginate(:page => params[:page], :per_page => 10).order('id DESC')
	end
	@title = "Vendas" 
	@subtitle = "Vendas Realizadas"
	@button_title = "Nova Venda"
	
  end

    def show
    @order = Order.find(params[:id])
	@title = "Detalhes"
	@subtitle = ""
	@order = Order.find(params[:id])
	@numeroItens =  0;
	@total =@order.amount;
	@order.ordercells.each do |ordercell|
		@numeroItens = @numeroItens.to_i +  ordercell.quantity
	end
	
	@valorCompra = 0
	if admin? && @order.status.to_s == Order::STATUS_CONFIRMED.to_s
		@order.ordercells.each do |ordercell|
			quantidade = ordercell.quantity
			ordercell.salecells.each do |sale|
				@valorCompra = @valorCompra + sale.quantity * sale.special_products.first.specialPrice.to_f
				quantidade = quantidade - sale.quantity
			end
			if quantidade > 0
				@valorCompra = @valorCompra + ordercell.products.first.regular_purchase_price.to_f * quantidade 
			end
		end
	end
	
  end

  # GET /Orders/new
  # GET /Orders/new.json
  def new
	if(params[:id])
		@order = Order.find(params[:id])
		@numeroItens =  0;
		@total = 0.0;
		@order.ordercells.each do |ordercell|
			@price = 0.0
			if ordercell.products.first.sale != nil
				@price =  ordercell.products.first.sale.salePrice * ordercell.quantity
				else 
					@price =  ordercell.products.first.regular_sale_price.to_f  * ordercell.quantity
				end	
				@total = @price + @total.to_f
				@numeroItens = @numeroItens.to_i +  ordercell.quantity
		end
	else	
		@order = Order.new
		@order.created =Time.now.strftime("%d/%m/%Y")
		@order.status = Order::STATUS_NEW
		@order.user = current_user
		@order.save
		@numeroItens = 0;
		@total = 0;
	end
	@message = nil
  end


  # POST /Orders
  # POST /Orders.json
  def create
    @order = Order.new(params[:order])
	  if @order.save  
		  redirect_to({:controller=> :orders, :action => :index}, :flash => { :notice_success => "Venda adicionada com sucesso" }) 
	  else
		  render "new"
	  end  
  end



  # DELETE /Orders/1
  # DELETE /Orders/1.json
  def destroy
    @order = Order.find(params[:id])
	@order.status = Order::STATUS_CONFIRMED
	@order.ordercells.each do |ordercell|
		@quantidade = ordercell.quantity
		if  @quantidade > 0 && @order.status ==  Order::STATUS_CONFIRMED
				ordercell.salecells.each do |sale|
				@aux = sale.quantity.to_i + sale.special_products.first.available.to_i
				sale.special_products.first.update_attributes(:available => @aux)			
				sale.save
			end
			ordercell.products.first.update_attributes(:in_stock_quantity => ordercell.quantity + ordercell.products.first.in_stock_quantity)
			ordercell.save
			ordercell.products.first.save
		end
	end	
	
	@order.status =  Order::STATUS_CANCELED
    if @order.save
		redirect_to({:controller=> :orders, :action => :index}, :flash => { :notice_success => "Venda cancelada com sucesso" }) 
	else  
		redirect_to({:controller=> :orders, :action => :index}, :flash => { :notice_error => "Erro ao cancelar Venda" }) 
	end  
  end
  
    def check_ajax  
	@title = "Vendas" 
	@product =  Product.where('barcode = ?', params[:codigo]).first
	@order = Order.find(params[:id])
	@ordercell = Ordercell.new
	@message = "erro"
	found = false
	@order.status = Order::STATUS_NEEDSPAYMENT
	if @product != nil
		if @product.in_stock_quantity  >= params[:quantidade].to_i
			@order.ordercells.each do |ordercell|			
				if ordercell.products.first == @product
					if @product.in_stock_quantity >= params[:quantidade].to_i + ordercell.quantity
						ordercell.quantity = ordercell.quantity + params[:quantidade].to_i
						ordercell.save
						@message = "success"
					end
					found = true
					break
				end	
			end	
			if !found
				@ordercell.products << @product
				@ordercell.quantity = params[:quantidade].to_i
				@message = "success"
					#checar agora se produto foi vendido com preco de catalogo
				@sales = Sale.where('product_id = ?', @product.id)
				@price = @product.regular_sale_price
				@sales.each do |sale|
					if sale.catalog.beginDate < @order.created  &&  sale.catalog.endDate > @order.created
						@price = sale.salePrice
						break
					end	
				end
				@ordercell.product_sold_price = @price.to_f
				@ordercell.save
				@order.ordercells << @ordercell
				@order.save
			end
		end
	end
	
	@numeroItens =  0;
	@total = 0.0;
	@order.ordercells.each do |ordercell|
			@total = ordercell.product_sold_price.to_f  * ordercell.quantity + @total.to_f
			@numeroItens = @numeroItens.to_i +  ordercell.quantity
	end
	@order.amount = @total.to_f
	@order.save
	respond_to do |format|
    format.js
  end
 end
  
 def payment
	@order = Order.find(params[:id])
	@order.status = Order::STATUS_CONFIRMED
	@payment_type = PaymentType.find(params[:payment_type][:id])
	
	if(@payment_type != nil)
		@order.payment_types << @payment_type
		@order.paymentType = @payment_type
		@order.discount = @payment_type.discount.to_f + params[:descontoExtra].to_f
		@order.consumerAmount = @order.amount.to_f * (1.to_f - @order.discount.to_f/100.to_f)
		@order.updated = Time.now
		@order.save
		@order.ordercells.each do |ordercell|
		#checar produtos diferenciados
		@special_products = SpecialProduct.where('product_id = ?', ordercell.products.first.id ).where('available > 0')
			@quantidade = ordercell.quantity
			if @special_products.count > 0 && @quantidade > 0
				@special_products.each do |special|
						@salecell = Salecell.new
						@salecell.special_products << special
						@salecell.quantity  = 0
						ordercell.products.first.update_attributes(:in_stock_quantity => ordercell.products.first.in_stock_quantity  - @quantidade)
						ordercell.save
						while @quantidade > 0 && special.available > 0
							@salecell.quantity = @salecell.quantity + 1
							special.update_attributes(:available => special.available - 1)
							@quantidade = @quantidade - 1
						end
						@salecell.save
						special.save	
						ordercell.salecells << @salecell
						ordercell.save
					end	
			else
				current_quantity = ordercell.products.first.in_stock_quantity - @quantidade
				ordercell.products.first.update_attributes(in_stock_quantity: current_quantity)
				ordercell.save
			end
		end			
		@order.save
		redirect_to({:controller=> :orders, :action => :index}, :flash => { :notice_success => "Venda confimada com sucesso" }) 
	else
		redirect_to({:controller=> :orders, :action => :index}, :flash => { :notice_error => "Erro ao confirmar Venda" })   
	end
  end

  
  
  end