class User < ActiveRecord::Base
  belongs_to :group
  attr_accessible :address, :birthDate, :cep, :city, :cpf, :email, :gender
  attr_accessible :login, :mobile, :name, :password_digest, :phone, :state
  attr_accessible :password, :password_confirmation
  attr_accessible :commission
  has_secure_password
  before_save :initial_values
  before_create { generate_token(:auth_token) }
# Validations   
  # validates_format_of :email, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i 
  # validates_format_of :phone, :with => /\A([1-9]{2})([- ]{0,1})(\d{3}|\d{4})([- ]{0,1})(\d{4})\Z/, :message => "telefone inválido DDD+número"
  # validates_format_of :mobile, :with => /\A([1-9]{2})([- ]{0,1})(\d{4}|\d{5})([- ]{0,1})(\d{4})\Z/, :message => "celular inválido DDD+número"
  # validates_format_of :cep, :with => /\A(\d{5})([-]{0,1})(\d{3})\Z/, :message => "CEP inválido"
  # validates_format_of :cpf, :with => /^\d{10,11}$|\d{3}\.\d{3}\.\d{3}-\d{2}$/, :message => "CPF inválido"  

  validates_uniqueness_of :login,:case_sensitive => false
  # validates_presence_of :email
  validates :name, presence: true
  validates :password, presence: { on: :create }, confirmation: true, length: { minimum: 6, on: :create }
  validates :password_confirmation, presence: { on: :create }, length: { minimum: 6, on: :create }
  # validates_presence_of :address, :message => "digite um endereço"
  # validates_presence_of :phone, :message => "digite um telefone"
  # validates_presence_of :mobile, :message => "digite um celular"
  # validates_presence_of :city, :message => "digite uma cidade"
  # validates_presence_of :cep, :message => "digite um CEP"
  # validates_presence_of :cpf, :message => "digite um CPF"
  
  validates :commission, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100, allow_blank: true }
  
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
  
  def self.searchByPage(page)
    paginate :per_page => 5, :page => page, :order => 'name'
  end

  def initial_values
    self.commission ||= 0.0
  end
  
end
