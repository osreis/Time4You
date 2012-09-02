class User < ActiveRecord::Base
  belongs_to :group
  attr_accessible :address, :birthDate, :cep, :city, :cpf, :email, :gender, :login, :mobile, :name, :password_digest, :phone, :state, :password, :password_confirmation
  has_secure_password
  before_create { generate_token(:auth_token) }
# Validations   
  validates_format_of :email, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i 
  validates_format_of :phone, :with => /\A([1-9]{2})([- ]{0,1})(\d{3}|\d{4})([- ]{0,1})(\d{4})\Z/, :message => "telefone inválido DDD+número"
  validates_format_of :mobile, :with => /\A([1-9]{2})([- ]{0,1})(\d{4}|\d{5})([- ]{0,1})(\d{4})\Z/, :message => "celular inválido DDD+número"
  validates_format_of :cep, :with => /\A(\d{5})([-]{0,1})(\d{3})\Z/, :message => "CEP inválido"
  validates_format_of :cpf, :with => /^\d{10,11}$|\d{3}\.\d{3}\.\d{3}-\d{2}$/, :message => "CPF inválido"  

  validates_uniqueness_of :login,:case_sensitive => false
  validates_presence_of :email  
  validates_presence_of :name
  validates_presence_of :password
  validates_presence_of :password_confirmation
  validates_confirmation_of :password
  validates_presence_of :address, :message => "digite um endereço"
  validates_presence_of :phone, :message => "digite um telefone"
  validates_presence_of :mobile, :message => "digite um celular"
  validates_presence_of :city, :message => "digite uma cidade"
  validates_presence_of :cep, :message => "digite um CEP"
  validates_presence_of :cpf, :message => "digite um CPF"
  validates_length_of :password, :minimum => 6, :message => "senha deve ter mais de 6 caracteres"
  validates_length_of :password_confirmation, :minimum => 6, :message => "senha deve ter mais de 6 caracteres"

  
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
