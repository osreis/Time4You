class SalesController < SeaOrdPagController

	before_filter :authorize
	before_filter :authorize_admin, :except=>[:my_profile, :update, :check_ajax]


	def get_page
		@sales = Sale.all
	end

  def index
		@title = "Promoções" 
		@subtitle = "Promoções de Catálogo"
		@button_title = "Adicionar Promoção"
		@sales = Sale.paginate(:page => params[:page], :per_page => 5)
	end # end index	
	

  def show
    @sale = Sale.find(params[:id])
    @title = "Detalhes"
	@subtitle = ""
  end

  # GET /sales/new
  # GET /sales/new.json
  def new
    @sale = Sale.new
	@edit = false
	@title = "Nova Promoçao"
	@subtitle = ""
	@legend = "Promoção"
	if params[:catalog]
		@catalog = Catalog.find(params[:catalog])
		@sale.catalog = @catalog
	end	
  end

  # GET /sales/1/edit
  def edit
    @title = "Editar Promoção"
	@subtitle = ""
	@legend =  "Nome do Produto" #@catalog.name
    @sale = Sale.find(params[:id])
  end

  # POST /sales
  # POST /sales.json
  def create
    @sale = Sale.new(params[:sale])
      if @sale.save
	  
		if params[:catalog]
		    redirect_to({:controller=> :catalogs, :action => :show, :id => params[:catalog]}, :flash => { :notice_success => "Promoção adicionada com sucesso" }) 
		else
       	  redirect_to({:controller=> :sales, :action => :index}, :flash => { :notice_success => "Promoção adicionada com sucesso" }) 
		end
	  else
		render "new"      
    end
  end

  # PUT /sales/1
  # PUT /sales/1.json
  def update
    @sale = Sale.find(params[:id])
      if @sale.update_attributes(params[:sale])
       	  redirect_to({:controller=> :sales, :action => :index}, :flash => { :notice_success => "Promoção alterada com sucesso" }) 
      else
		render "edit"
    end
  end

  # DELETE /sales/1
  # DELETE /sales/1.json
  def destroy
    @sale = Sale.find(params[:id])
    if @sale.destroy
       	 redirect_to({:controller=> :sales, :action => :index}, :flash => { :notice_success => "Promoção removida com sucesso" }) 
    else  
		redirect_to({:controller=> :sales, :action => :index}, :flash => { :notice_error => "Erro ao remover promoção" }) 
	end  
  end
  
end
