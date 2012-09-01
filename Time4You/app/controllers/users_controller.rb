﻿ class UsersController < SeaOrdPagController

	before_filter :authorize
	before_filter :authorize_admin, :except=>[:my_profile, :update, :check_ajax]


	def get_page
		@users = User.all
	end



	def index
		@title = t(:user_index_title) 
		@subtitle = t(:user_index_subtitle)
		@button_title = t(:user_index_button_title)
		if params[:from] == "menu" #reset session parameters
		   init
		end
		get_page
	end # end index



	def new  
		@title = t(:user_new_title)
		@subtitle = t(:user_new_subtitle)
		@legend = t(:user_new_legend)
		@user = User.new  
		@grupos = Group.all
		@edit = false
	end  
  
  
	def create
		@group = Group.where(:internal_id => params[:group][:id].to_s).first
		@user = User.new(params[:user])  
		@user.group = @group
		if @user.save  
			redirect_to({:controller=> :users, :action => :index}, :flash => { :notice_success => t(:add_new_user_success) }) 
		else  
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
	end # end destroy_user

	def show
	  @user = User.find(params[:id])
	  @title = "Detalhes"
	  @subtitle = ""
	end # end


	def my_profile # renders the containning of My Profile Page
		@user = current_user
		@title = t(:user_my_profile_title)
		@subtitle = t(:user_my_profile_subtitle)
		@legend = t(:user_my_profile_legend)
	end

	def edit
		@grupos = Group.all
		@edit = true
		@user = User.find(params[:id])
		@title = t(:user_edit_title)
		@subtitle = t(:user_edit_subtitle)
		@legend = @user.name
	end



	def update
	  @user = User.find(params[:id])
	  puts "**************************" + @user.to_s
      if @user.update_attribute(:email, params[:user][:email]) and @user.update_attribute(:address, params[:user][:address]) and @user.update_attribute(:city, params[:user][:city]) and @user.update_attribute(:state, params[:user][:state]) and @user.update_attribute(:phone, params[:user][:phone]) and @user.update_attribute(:mobile, params[:user][:mobile]) and @user.update_attribute(:login, params[:user][:login])  
       	redirect_to({:controller=> :users, :action => :index}, :flash => { :notice_success => "Usuário alterado com sucesso" }) 
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