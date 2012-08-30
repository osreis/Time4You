class SeaOrdPagController < ApplicationController
	# define as variaveis para montar a pagination dos grids
	# pagina_atual: pagina que será mostrada
	# total_itens: total de todos os itens a serem visualizados sem pagination
	def pagination(total_itens)
		if total_itens.to_i > 0
		# descobre o numero total de paginas disponiveis
			if total_itens.to_i % Constants::ITENS_PAGE.to_i == 0
				@total_pages = total_itens.to_i / Constants::ITENS_PAGE.to_i
			else
				@total_pages = (total_itens.to_i / Constants::ITENS_PAGE.to_i) + 1
			end  
		end

		# disponibiliza as variaveis para a view
		@total_itens = total_itens
	end  

# Session  
	def order
		if session[:"#{controller_name}_order"] == nil
			session[:"#{controller_name}_order"] = "asc"
		end
		return session[:"#{controller_name}_order"]
	end
	
	def order=(value)
		session[:"#{controller_name}_order"] = value
	end

	def col_order
		if session[:"#{controller_name}_col_order"] == nil
			session[:"#{controller_name}_col_order"] = "name"
		end
		return session[:"#{controller_name}_col_order"]
	end
	
	def col_order=(value)
		session[:"#{controller_name}_col_order"] = value
	end

	def current_page
		if session[:"#{controller_name}_current_page"] == nil
			session[:"#{controller_name}_current_page"] = 1
		end
		return session[:"#{controller_name}_current_page"]   
	end
	
	def current_page=(value)
		session[:"#{controller_name}_current_page"] = value
	end


	def search_filter
		if session[:"#{controller_name}_search_filter"] == nil
			session[:"#{controller_name}_search_filter"] = "all"
		end
		return session[:"#{controller_name}_search_filter"]   
	end
	
	def search_filter=(value)
		session[:"#{controller_name}_search_filter"] = value
	end

	def search_value
		if session[:"#{controller_name}_search_value"] == nil
			session[:"#{controller_name}_search_value"] = ""
		end
		return session[:"#{controller_name}_search_value"]     
	end
	
	def search_value=(value)
		session[:"#{controller_name}_search_value"] = value
	end
# end of Session
	
	#Atualiza parametros da sessao e obtem o que será renderizado na pagina
	def get_page_results(model_name)

		# Ordena os resultados
		if self.search_filter != "all"
			results = model_name.where(:"#{self.search_filter}" => /#{self.search_value}/i).order_by([:"#{self.col_order}", :"#{self.order}"])
		else
			results = model_name.all.order_by([:"#{self.col_order}", :"#{self.order}"])
		end
		
		# pagina os resultados
		results = results.skip(Constants::ITENS_PAGE.to_i * (self.current_page.to_i - 1)).limit(Constants::ITENS_PAGE.to_i)
		# chama o metodo pagination da application_controller para enviar os dados de pagination para a view
		pagination(results.count)

		# envia os valores das variaves de grid para a view
		@search_value = self.search_value
		@col_order = self.col_order
		@order = self.order
		@current_page = self.current_page
		
		return results
	end  
	
	# força a reinicialização das variaveis de sessao
	def init
		self.order = nil
		self.col_order = nil
		self.current_page = nil
		self.search_filter = nil
		self.search_value = nil
	end 	  
	
	# pagination
	def change_page
		self.current_page = params[:page]

		get_page
		respond_to do |format|
		        format.html {render :partial => 'table'}
		end	
	end

	def change_order
		self.col_order = params[:col_name]
		self.order = params[:order]

		get_page
		respond_to do |format|
		        format.html {render :partial => 'table'}
		end	
	end


	# filtra por uma valor informado pelo usuario
	def filter_search
		self.search_value = params[:search]
		self.search_filter = params[:search_select]
		self.current_page = 1

		get_page
		respond_to do |format|
		        format.html {render :partial => 'table'}
		end	
	end
	
end
