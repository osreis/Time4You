class Brand < ActiveRecord::Base
  attr_accessible :extra_info, :name, :representative_email, :representative_name, :representative_phone
  validates_presence_of :name
end
