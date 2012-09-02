class BrandsController < ApplicationController
  # GET /brands
  # GET /brands.json
  def index
    @brands = Brand.all
    @title = t(:brand_index_title)
    if (@brands.empty?)
      @subtitle = t(:empty_brand_table)
    else 
      @subtitle = t(:brand_index_subtitle)
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @brands }
    end
  end

  # GET /brands/1
  # GET /brands/1.json
  def show
    @brand = Brand.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @brand }
    end
  end

  # GET /brands/new
  # GET /brands/new.json
  def new
    @brand = Brand.new
    @title = t(:brand_new_title)
    @subtitle = t(:brand_new_subtitle)

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @brand }
    end
  end

  # GET /brands/1/edit
  def edit
    @brand = Brand.find(params[:id])
    @title = "Editando Marca"
  end

  # POST /brands
  # POST /brands.json
  def create
    @brand = Brand.new(params[:brand])

    respond_to do |format|
      if @brand.save
        format.html { redirect_to brands_path, :flash => { :notice_success => "#{@brand.name} criada com sucesso!" } }
        format.json { render json: @brand, status: :created, location: @brand }
      else
        format.html { render action: "new" }
        format.json { render json: @brand.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /brands/1
  # PUT /brands/1.json
  def update
    @brand = Brand.find(params[:id])

    respond_to do |format|
      if @brand.update_attributes(params[:brand])
        format.html { redirect_to @brand, :flash => { :notice_success => "#{@brand.name} editada com sucesso!" } }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @brand.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /brands/1
  # DELETE /brands/1.json
  def destroy
    @brand = Brand.find(params[:id])
    if @brand.delete
		redirect_to({:controller=> :brands, :action => :index}, :flash => { :notice_success => "Marca removida com sucesso" }) 
	else  
		redirect_to({:controller=> :brands, :action => :index}, :flash => { :notice_error => "Erro ao remover marca" }) 
	end  
  end
end
