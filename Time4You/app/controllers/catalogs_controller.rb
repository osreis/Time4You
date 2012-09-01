class CatalogsController < SeaOrdPagController

   before_filter :authorize
    
   def get_page
		 @catalogs = Catalog.all
	end
	
	
	
	def index
		@title = "Catálogos" 
		@subtitle = "Catálogos de Produtos"
		@button_title = "Adicionar Catálogo"
		if params[:from] == "menu" #reset session parameters
		   init
		end
		get_page
	end # end index	
	
  def show
    @catalog = Catalog.find(params[:id])
	#@produtos = @catalog.produtos
	@title = "Detalhes"
	@subtitle = ""
  end

  # GET /catalogs/new
  # GET /catalogs/new.json
  def new
    @edit = false
	  @title = "Novo Catálogo"
	  @subtitle = ""
	  @legend = "Catálogo"
    @catalog = Catalog.new
  end

  # GET /catalogs/1/edit
  def edit
    @edit = true
    @catalog = Catalog.find(params[:id])
	  @catalog.beginDate =  @catalog.beginDate.strftime("%d/%m/%Y")
	  @catalog.endDate =  @catalog.endDate.strftime("%d/%m/%Y")
	  @title = "Editar Catálogo"
	  @subtitle = ""
	  @legend = @catalog.name
  end

  # POST /catalogs
  # POST /catalogs.json
  def create
    @catalog = Catalog.new(params[:catalog])
	  if @catalog.save  
		  redirect_to({:controller=> :catalogs, :action => :index}, :flash => { :notice_success => "Catálogo adicionado com sucesso" }) 
	  else
	    puts "\n\n\n\n\n\n\n Id: #{@catalog.id} \n\n\n\n\n\n\n\n\n"
  	  puts "\n\n\n\n\n\n\n Nome: #{@catalog.name} \n\n\n\n\n\n\n\n\n"
    	puts "\n\n\n\n\n\n\n Id_marca: #{@catalog.brand_id.to_s} \n\n\n\n\n\n\n\n\n"
    	puts "\n\n\n\n\n\n\n Begin_Date: #{@catalog.beginDate} \n\n\n\n\n\n\n\n\n"
    	puts "\n\n\n\n\n\n\n End_Date: #{@catalog.endDate} \n\n\n\n\n\n\n\n\n"
		  render "new"
	  end  
  end

  # PUT /catalogs/1
  # PUT /catalogs/1.json
  def update
    @catalog = Catalog.find(params[:id])
	if @catalog.update_attributes(params[:catalog])
		redirect_to({:controller=> :catalogs, :action => :index}, :flash => { :notice_success => "Catálogo alterado com sucesso" }) 
	else  
		render "edit"  
	end  
  end

  # DELETE /catalogs/1
  # DELETE /catalogs/1.json
  def destroy
    @catalog = Catalog.find(params[:id])
    if @catalog.delete
		redirect_to({:controller=> :catalogs, :action => :index}, :flash => { :notice_success => "Catálogo removido com sucesso" }) 
	else  
		redirect_to({:controller=> :catalogs, :action => :index}, :flash => { :notice_error => "Erro ao remover catálogo" }) 
	end  
  end
  
end
