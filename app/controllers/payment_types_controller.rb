class PaymentTypesController < ApplicationController
  # GET /payment_types
  # GET /payment_types.json
  before_filter :authorize
  before_filter :authorize_admin

 def index
		@title = "Tipos de Pagamentos" 
		@subtitle = "Tipos de Pagamentos"
		@button_title = "Adicionar Tipo de Pagamento"
		@payment_types = PaymentType.all
	end # end index	
	


  # GET /PaymentTypes/new
  # GET /PaymentTypes/new.json
  def new
	@title = "Novo Tipo de Pagamento"
	@subtitle = ""
	@legend = "Tipo de Pagamento"
    @payment_type = PaymentType.new
  end

  # GET /PaymentTypes/1/edit
  def edit
    @payment_type = PaymentType.find(params[:id])
	@title = "Editar Tipo de Pagamento"
	@subtitle = ""
	@legend = @payment_type.name
  end

  # POST /PaymentTypes
  # POST /PaymentTypes.json
  def create
    @payment_type = PaymentType.new(params[:payment_type])
	  if @payment_type.save  
		  redirect_to({:controller=> :payment_types, :action => :index}, :flash => { :notice_success => "Tipo de Pagamento adicionado com sucesso" }) 
	  else
		  render "new"
	  end  
  end

  # PUT /PaymentTypes/1
  # PUT /PaymentTypes/1.json
  def update
    @payment_type = PaymentType.find(params[:id])
	if @payment_type.update_attributes(params[:payment_type])
		redirect_to({:controller=> :payment_types, :action => :index}, :flash => { :notice_success => "Tipo de Pagamento alterado com sucesso" }) 
	else  
		render "edit"  
	end  
  end

  # DELETE /PaymentTypes/1
  # DELETE /PaymentTypes/1.json
  def destroy
    @payment_type = PaymentType.find(params[:id])
    if @payment_type.delete
		  redirect_to({:controller=> :payment_types, :action => :index}, :flash => { :notice_success => "Tipo de Pagamento removido com sucesso" }) 
	  else  
		  redirect_to({:controller=> :payment_types, :action => :index}, :flash => { :notice_error => "Erro ao remover Tipo de Pagamento" }) 
	  end  
  end
  
  end
