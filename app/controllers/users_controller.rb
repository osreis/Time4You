﻿ class UsersController < SeaOrdPagController

	before_filter :authorize
	before_filter :authorize_admin, :except=>[:my_profile, :update, :check_ajax]


	def index
		@title = t(:user_index_title) 
		@subtitle = t(:user_index_subtitle)
		@button_title = t(:user_index_button_title)
		if (params[:query] && !params[:query].empty?)
		  if (params[:query_option] == "Nome")
		    @users = User.where('name like ?', "%#{params[:query]}%")
	    elsif(params[:query_option] == "E-mail")
	      @users = User.where('email = ?', "#{params[:query]}")  
      elsif(params[:query_option] == "Login")
        @users = User.where('login like ?', "%#{params[:query]}%")
      elsif(params[:query_option] == "CPF")
        @users = User.where('cpf = ?', "#{params[:query]}")
      end
		else
		  @users = User.where('id != ?', current_user.id)
	  end
	  @users = @users.searchByPage(params[:page])
	end



	def new  
		@title = t(:user_new_title)
		@subtitle = t(:user_new_subtitle)
		@legend = t(:user_new_legend)
		@user = User.new  
		@grupos = Group.all
		@edit = false
		@myProfile = false
	end  
  
  
	def create
		@group = Group.where(:internal_id => params[:group][:id].to_s).first
		@user = User.new(params[:user])  
		@user.group = @group
		if @user.save  
			redirect_to({:controller=> :users, :action => :index}, :flash => { :notice_success => t(:add_new_user_success) }) 
		else
			puts @user.errors.messages
			render "new"  
		end  
	end  # end create



	def destroy
	  @user = User.find(params[:id])
		if @user.delete  
			redirect_to({:controller=> :users, :action => :index}, :flash => { :notice_success => t(:remove_user_success)}) 
		else  
			redirect_to({:controller=> :users, :action => :index}, :flash => { :notice_error => t(:remove_user_fail)}) 
		end  
	end 
	
	
	def recovery
	  @user = User.find(params[:id])
	  @user.password = "time4you"
	  @user.password_confirmation = "time4you"
	  if @user.save  
			redirect_to({:controller=> :users, :action => :index}, :flash => { :notice_success => "A senha do usuário foi resetada para time4you. "}) 
		else  
			redirect_to({:controller=> :users, :action => :index}, :flash => { :notice_error => "Erro ao resetar a senha do usuário." }) 
		end  
	end 
	
	
	def show
	  @user 	= User.find(params[:id])
	  @title 	= "Detalhes"
	end # end


	def my_profile # renders the containning of My Profile Page
		@user = current_user
		@title = t(:user_my_profile_title)
		@subtitle = t(:user_my_profile_subtitle)
		@legend = t(:user_my_profile_legend)
		@myProfile = true
		@edit = true
	end

	def edit
		@grupos = Group.all
		@edit = true
		@myProfile = false
		@user = User.find(params[:id])
		@title = t(:user_edit_title)
		@subtitle = t(:user_edit_subtitle)
		@legend = @user.name
	end



	def update
	  @user = User.find(params[:id])
	  params_cpy = params[:user]
	  params_cpy.delete(:old_password)
      if @user.update_attributes(params_cpy)  
       	if @user != current_user
		redirect_to({:controller=> :users, :action => :index}, :flash => { :notice_success => "Usuário alterado com sucesso" }) 
		elsif   @user.update_attribute(:password, params[:user][:password]) and @user.update_attribute(:password_confirmation, params[:user][:password_confirmation])
			redirect_to({:controller=> :home, :action => :index}, :flash => { :notice_success => "Usuário alterado com sucesso" }) 
		end	
	  else
		render "edit"
	  end
  	end


	def admin_update # update user's params, by an Admin call

		@user = User.find(params[:user][:id])
		# tries to update each model enabled param
			save = false
		if User::ADMIN_CAN_EDIT_NAME
			if @user.update_attribute(:name, params[:user][:name])
				save = true
			end	
		end

		if User::ADMIN_CAN_EDIT_EMAIL and @user.email != params[:user][:email]
			if @user.update_attribute(:email, params[:user][:email])
				save = true
			end	
		end

		if User::ADMIN_CAN_EDIT_GROUP
			group = Group.find(params[:group][:id])
			if @user.update_attribute(:group_id, group.id)
				save = true
			end	
		end

		if save
			redirect_to({:controller=> :users, :action => :index}, :flash => { :notice_success => t(:edit_user_success) }) 
		else 	
			redirect_to({:controller=> :users, :action => :index}, :flash => { :notice_error => t(:edit_user_fail)}) 
		end 
	end # end admin_update




	def check_ajax # method to verify if the old password is correct, from My Profile
		@user = current_user
		if @user.authenticate(params[:password]) 
			render :text => true.to_s
		else
			render :text => false.to_json
		end
 	end # end check ajax


end  # end Class