class OrdersController < ApplicationController

  def index
    @orders = Order.paginate(:page => params[:page], :per_page => 5)
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
  end

  # GET /Orders/new
  # GET /Orders/new.json
  def new
    @order = Order.new
	@order.save
	@numeroItens = 0;
	@total = 0;
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
    if @order.delete
		redirect_to({:controller=> :orders, :action => :index}, :flash => { :notice_success => "Venda removida com sucesso" }) 
	else  
		redirect_to({:controller=> :orders, :action => :index}, :flash => { :notice_error => "Erro ao remover Venda" }) 
	end  
  end
  
    def check_ajax  
	@title = "Vendas" 
	@product =  Product.where('barcode = ?', params[:codigo]).first
	@order = Order.find(params[:id])
	@ordercell = Ordercell.new
	@message = "erro"
	found = false
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
	
	@numeroItens =  @order.ordercells.count;
	@total = 0.0;
	@order.ordercells.each do |ordercell|
			@total = ordercell.product.regular_sale_price.to_f + @total.to_f
	end
	
	 respond_to do |format|
    format.js
  end
 end
  
  
  
  end
