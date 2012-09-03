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
	@title = "Nova Venda"
	@subtitle = ""
	@legend = "Venda"
    @order = Order.new
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
  
  end
