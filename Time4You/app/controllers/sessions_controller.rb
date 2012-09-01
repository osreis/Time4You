class SessionsController < ApplicationController  
 
  def login  
	  if current_user
		  redirect_to({:controller=> :home, :action => :index}) 
	  else
		  render  :layout => nil # login page layout is unique
	  end
  end  #end login
   
  
  def check_ajax  
   # method that verifies user login and password
    user = User.where(:login => params[:email].to_s).first
    if user && user.authenticate(params[:password])  
		session[:user_id] = user.id
      if params[:remember_me] 
        cookies.permanent[:auth_token] = user.auth_token  
      else  
        cookies[:auth_token] = user.auth_token    
      end   
   	  render :text => true.to_s
    else  
	    render :text => false.to_s
    end  
  end  # end check_ajax
  
  
  def logout  
	  session[:user_id] = nil
	  cookies.delete(:auth_token)  
	  redirect_to({:controller=> :sessions, :action => :login}, :flash => { :notice_success => t(:session_logout) })
  end  #end logout 
  
  
  
end #end Class