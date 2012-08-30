class User < ActiveRecord::Base
  belongs_to :group
  attr_accessible :address, :birthDate, :cep, :city, :cpf, :email, :gender, :login, :mobile, :name, :password_digest, :phone, :state, :password, :password_confirmation
  has_secure_password
  before_create { generate_token(:auth_token) }

  User::CAN_EDIT_EMAIL = false
  User::CAN_EDIT_GROUP = false
  User::CAN_EDIT_NAME = true
  
  # constants to define the editable params by administrator in user edit
  User::ADMIN_CAN_EDIT_EMAIL = true
  User::ADMIN_CAN_EDIT_GROUP = true
  User::ADMIN_CAN_EDIT_NAME = true
  def generate_token(column)  
    begin  
      self[column] = SecureRandom.urlsafe_base64  	
	end  
  end
end
