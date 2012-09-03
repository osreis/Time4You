class Brand < ActiveRecord::Base
  attr_accessible :extra_info, :name, :representative_email, :representative_name, :representative_phone
  has_many :catalogs
  has_many :products
  validates_presence_of :name
  validates_format_of :representative_email, :with => Regex::EMAIL, :message => Messages::FORMATO_EMAIL, :allow_blank => true
  validates_format_of :representative_phone, :with => Regex::MOBILE, :message => Messages::FORMATO_TELEFONE, :allow_blank => true
end
