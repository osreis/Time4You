class UsersController < SeaOrdPagController

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
	end  
  
  
	def create
		@group = Group.where(:internal_id => params[:group][:id].to_s).first
		if current_user.group.internal_id <= Group::CADASTRO.to_i
			@instituicao = Instituicao.find(params[:instituicao][:id].to_s)
		else
			@instituicao = current_user.instituicao
		end	
		@user = User.new(params[:user])  
		@user.group = @group
		@user.instituicao = @instituicao
		if @user.save  
			redirect_to({:controller=> :users, :action => :index}, :flash => { :notice_success => t(:add_new_user_success) }) 
		else  
		render "new"  
		end  
	end  # end create
	
	
	
	def destroy_user
	  @user = User.find(params[:id])
	  if @user.registro_medicos.count == 0
		if @user.delete  
			redirect_to({:controller=> :users, :action => :index}, :flash => { :notice_success => t(:remove_user_success)}) 
		else  
			redirect_to({:controller=> :users, :action => :index}, :flash => { :notice_error => t(:remove_user_fail)}) 
		end  
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
	
	
	
	def update # update user's params from My Profile
	
		@user = current_user
		if @user.authenticate(params[:user][:old_password]) 
			@user.password = params[:user][:password] 
			@user.password_confirmation = params[:user][:password_confirmation] 
			
			if @user.OrgExp.nil?
				@user.OrgExp = "SSP"
			end	
			if @user.save
				redirect_to({:controller=> :home, :action => :index}, :flash => { :notice_success => t(:update_my_profile_success) }) # TODO: change the redirect to your root view
			else
				redirect_to({:controller=> :home, :action => :index}, :flash => { :notice_error => t(:update_my_profile_fail) }) 
			end 
		else 
			redirect_to({:controller=> :users, :action => :my_profile}, :flash => { :notice_error => t(:update_my_profile_fail) })
		end 
	end #end update
	
	
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
