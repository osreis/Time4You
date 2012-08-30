class Group < ActiveRecord::Base
  attr_accessible :internal_id, :name
  has_many :users
  
  validates_uniqueness_of :name,:case_sensitive => true
  validates_presence_of :name
  
  
  # constants
  Group::ADMIN = '1'
  Group::VENDEDOR = '2'
end
