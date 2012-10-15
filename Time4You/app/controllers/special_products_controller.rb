class SpecialProductsController < SeaOrdPagController

	before_filter :authorize
	before_filter :authorize_admin, :except=>[:my_profile, :update, :check_ajax]


	def get_page
		@special_products = SpecialProduct.all
	end

  def index
		@title = "Produtos Diferenciados" 
		@subtitle = "Produtos adquiridos com preços especiais"
		@button_title = "Adicionar Produto"
		if params[:from] == "menu" #reset session parameters
		   init
		end
		get_page
	end # end index	
	

  def show
    @special_product = SpecialProduct.find(params[:id])
    @title = "Detalhes"
	@subtitle = ""
  end

  def new
    @special_product = SpecialProduct.new
	@edit = false
	@title = "Nova Diferenciação"
	@subtitle = ""
	@legend = "Diferenciação"
    # TODO linkar com o produto, a partir da tela de show ou da tabela dele
	if params[:product]
		@catalog = Catalog.find(params[:catalog])
	end	
  end

  def edit
    @title = "Editar Diferenciação"
	@subtitle = ""
	@legend =  "Nome do Produto" #@catalog.name
    @special_product = SpecialProduct.find(params[:id])
  end

  def create
    @special_product = SpecialProduct.new(params[:special_product])
      if @special_product.save
	  
		if params[:product]
		    redirect_to({:controller=> :products, :action => :show, :id => params[:catalog]}, :flash => { :notice_success => "Diferenciação adicionada com sucesso" }) 
		else
       	  redirect_to({:controller=> :special_products, :action => :index}, :flash => { :notice_success => "Diferenciação adicionada com sucesso" }) 
		end
	  else
		render "new"      
    end
  end

  def update
    @special_product = SpecialProduct.find(params[:id])
      if @special_product.update_attributes(params[:special_product])
       	  redirect_to({:controller=> :special_products, :action => :index}, :flash => { :notice_success => "Diferenciação alterada com sucesso" }) 
      else
		render "edit"
    end
  end

  def destroy
    @special_product = SpecialProduct.find(params[:id])
    if @special_product.destroy
      redirect_to({:controller=> :special_products, :action => :index}, :flash => { :notice_success => "DIferenciação removida com sucesso" }) 
    else  
		  redirect_to({:controller=> :special_products, :action => :index}, :flash => { :notice_error => "Erro ao remover diferenciação" }) 
	 end  
  end

  def check_ajax
    respond_to do |format|
      format.js
    end
  end


 end