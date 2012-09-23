class OrdersController < ApplicationController

  def index
		
	@orders = Order.paginate(:page => params[:page], :per_page => 10).order('id DESC')
	@title = "Vendas" 
	@subtitle = "Vendas Realizadas"
	@button_title = "Nova Venda"
	
  end

    def show
    @order = Order.find(params[:id])
	#@produtos = @order.produtos
	@title = "Detalhes"
	@subtitle = ""
	@sales = @order.sales.paginate(:page => params[:page], :per_page => 5)
		@order = Order.find(params[:id])
	@order.status = Order::STATUS_CONFIRMED
	@numeroItens =  0;
	@total =@order.amount;
	@order.ordercells.each do |ordercell|
		@price = 0.0
		if ordercell.product.sale != nil
			@price =  ordercell.product.sale.salePrice
			else 
				@price =  ordercell.product.regular_sale_price.to_f
			end	
			@total = @price + @total.to_f
			@numeroItens = @numeroItens.to_i +  ordercell.quantity
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
			if ordercell.product.sale != nil
				@price =  ordercell.product.sale.salePrice * ordercell.quantity
				else 
					@price =  ordercell.product.regular_sale_price.to_f  * ordercell.quantity
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

  # GET /Orders/1/edit
  def edit
    @order = Order.find(params[:id])
	@order.created =  @order.created.strftime("%d/%m/%Y")
	@title = "Editar Venda"
	@subtitle = ""
	@legend = @order.name
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

  # PUT /Orders/1
  # PUT /Orders/1.json
  def update
    @order = Order.find(params[:id])

	if @order.update_attributes(params[:order])
		redirect_to({:controller=> :orders, :action => :index}, :flash => { :notice_success => "Venda alterada com sucesso" }) 
	else  
		render "edit"  
	end  
  end

  # DELETE /Orders/1
  # DELETE /Orders/1.json
  def destroy
    @order = Order.find(params[:id])
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
		
		if @product.in_stock_quantity >= params[:quantidade].to_i
			@order.ordercells.each do |ordercell|
				if ordercell.product == @product
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
				@ordercell.product = @product
				@ordercell.quantity = params[:quantidade].to_i
				@ordercell.save
				@order.ordercells << @ordercell
				@message = "success"
			end
		end
	end
	
	@numeroItens =  0;
	@total = 0.0;
	@order.ordercells.each do |ordercell|
		@price = 0.0
		if ordercell.product.sale != nil
			@price =  ordercell.product.sale.salePrice * ordercell.quantity
			else 
				@price =  ordercell.product.regular_sale_price.to_f  * ordercell.quantity
			end	
			@total = @price + @total.to_f
			@numeroItens = @numeroItens.to_i +  ordercell.quantity
	end
	@order.amount = @total
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
		@order.payment_type = @payment_type
		@order.discount = @payment_type.discount.to_f + params[:descontoExtra].to_f
		@order.consumerAmount = @order.amount * (1 - @order.discount)
		@order.save
	end
	@order.updated = Time.now
end 
  
  
  
  end
