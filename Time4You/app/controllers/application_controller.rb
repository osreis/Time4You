# encoding: utf-8

class ApplicationController < ActionController::Base
  
  
	protect_from_forgery
	require 'rails/all'
	helper_method :current_user, :authorize, :authorize_admin, :admin?

	private  

	def current_user  # returns the session user
		@current_user ||= User.find(session[:user_id]) if session[:user_id]
	end  
    
	def authorize # verifies if the session has a logged user
		unless current_user
			redirect_to({:controller=> :sessions, :action => :login}, :flash => { :notice_error => t(:session_expired) })
			false
		end
	end # end authorize
	
	def authorize_admin # verifies if the session has a logged user that belongs to Admin group
		if current_user.group.internal_id.to_i == Group::ADMIN.to_i
			true
		else
			redirect_to({:controller=> :home, :action => :index}, :flash => { :notice_error => t(:not_authorized) }) 
		end
	end #end authorize_admin
	
	def admin? # verifies if the user belongs to admin group
		if current_user.group.internal_id.to_i == Group::ADMIN.to_i
			true
		else
			false
		end
	end #end admin?
	

end # end Class
