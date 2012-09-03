require 'fileutils'
class BackupsController < ApplicationController


  def index
  	@title = "Backups" 
	@subtitle = "Controle dos Backups do Sistema"
	@button_title = "Realizar Backup"
	@backups = Backup.paginate(:page => params[:page], :per_page => 5)
  end


  def new
    @backup = Backup.new
	ctime=Time.now.strftime("%Y_%m_%d") 
	FileUtils.cp "db/development.sqlite3", "backup/" + ctime.to_s + ".sqlite3"
	@backup.date = Time.now
	@backup.file = "backup/" + ctime.to_s + ".sqlite3"
	if @backup.save
       	 redirect_to({:controller=> :backups, :action => :index}, :flash => { :notice_success => "Backup realizado com sucesso" }) 
    else  
		redirect_to({:controller=> :backups, :action => :index}, :flash => { :notice_error => "Erro ao realizar backup" }) 
	end  
	
  end

  
  def destroy
    @backup = Backup.find(params[:id])
	path = @backup.file
	@backup.destroy
	if @backup.destroy
		FileUtils.remove_file path
       	 redirect_to({:controller=> :backups, :action => :index}, :flash => { :notice_success => "Backup removido com sucesso" }) 
    else  
		redirect_to({:controller=> :backups, :action => :index}, :flash => { :notice_error => "Erro ao remover backup" }) 
	end  
	
	
  end
  
  def restaurar
	begin
		@backup = Backup.find(params[:id])
		FileUtils.cp @backup.file, "db/development.sqlite3"
		redirect_to({:controller=> :backups, :action => :index}, :flash => { :notice_success => "Backup restaurado com sucesso. Por favor reinicie o sistema." }) 
	rescue
		redirect_to({:controller=> :backups, :action => :index}, :flash => { :notice_error => "Não foi poss;ivel restaurar o backup." }) 
	end
  end
  
  def download
   @backup = Backup.find(params[:id])
    send_file @backup.file
end
  
end
