module ApplicationHelper
  def br_states
  [
    ['Acre', 'AC'],
    ['Alagoas', 'AL'],
    ['Amapá', 'AP'],
    ['Amazonas', 'AM'],
    ['Bahia', 'BA'],
    ['Ceará', 'CE'],
    ['Distrito Federal', 'DF'],
    ['Espírito Santo', 'ES'],
    ['Goiás', 'GO'],
    ['Maranhão', 'MA'],
    ['Mato Grosso', 'MT'],
    ['Mato Grosso do Sul', 'MS'],
    ['Minas Gerais', 'MG'],
    ['Pará', 'PA'],
    ['Paraába', 'PB'],
    ['Paraná', 'PR'],
    ['Pernambuco', 'PE'],
    ['Piauí', 'PI'],
    ['Rio de Janeiro', 'RJ'],
    ['Rio Grande do Norte', 'RN'],
    ['Rio Grande do Sul', 'RS'],
    ['Rondônia', 'RO'],
    ['Roraima', 'RR'],
    ['Santa Catarina', 'SC'],
    ['São Paulo', 'SP'],
    ['Sergipe', 'SE'],
    ['Tocantins', 'TO']
  ]
  end
  
   def sexos
	[
		['Masculino','Masculino'],
		['Feminino','Feminino']
	]
   end
  
  def tipo_relatorio_exames
	[		
		['Detalhamento Diário','day_details'],
		['Maiores Exames','top_exames'],
		['Quantidade de Exames por Período', 'period_exam']
	]
   end
   def tipo_relatorio_exames_inst
	[		
		['Detalhamento Diário','day_details'],
		['Quantidade de Exames por Período', 'period_exam']
	]
   end
   
  def tipo_relatorio_registros
	[		
		['Detalhamento Diário de Moéstias','day_details'],
		['Maiores Moléstias','top_molestias'],
		['Quantidade de Registros por Período', 'period_registers']
	]
   end
   
   
  def layout_edit_and_new  
    # renders the html code for New and Edit pages
    
    html = <<-HTML
    
    
    <div class="grid_16">

    	<h1>
    		#{ @title.to_s }
    	</h1>

    	<p>  #{ @subtitle.to_s } </p>


    	<div class="clear"></div>

    	<p></p>

    	<div>
            <fieldset class="login">
                <legend>#{ @legend.to_s }</legend>
    			#{ render 'form' }
                <div>
    			</div>
            </fieldset>
    	</div>
    </div>
    HTML

        html.html_safe
  end
  
  def loading_div 
    # renders the loading div
    
    html = <<-HTML
    
    
    <div id="loading" style="display:none">  
    	#{ t(:loadin_message) }
    	<img src="/assets/loading/ajax-loader.gif" alt="loading.." />  
    </div>
    HTML

        html.html_safe
  end
  
  
  def submit_div 
    # renders the submit div
    
    html = <<-HTML
    
    
    <div align="right"> 
    	 #{ submit_tag t(:submit_save), :class => "button" } #{ t(:action_or) } #{ link_to t(:page_back), :back, :class => "back" }
    </div>
    HTML

        html.html_safe
  end
  
  def index_header 
    # renders header of index view
    
    html = " 
    <h1> #{ @title }  </h1>
    <p>  #{ @subtitle } </p>"

    flash.each do |name, msg| 
      html += "	#{ content_tag :div, msg, :id => "flash_#{name}"}"

      end
        html.html_safe
  end
  
  
  def index_content (href) 
    # renders header of index view
    
	if href == "sem link"
	 html = <<-HTML
    
    
    <div align="right"> 
    </div>
    <br/>
    <div id="table_container" >
    	#{ render "table" }
    </div>
  
    HTML
	
	else
	
    html = <<-HTML
    
    
    <div align="right"> 
    	<a href="#{href}"  class="big positive button"> #{ @button_title.to_s }</a> 
    </div>
    <br/>
    <div id="table_container" >
    	#{ render "table" }
    </div>
  
    HTML
	end
	
        html.html_safe
  end
  
  
  
end
