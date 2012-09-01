class Catalog < ActiveRecord::Base
 
  belongs_to :brand
  attr_accessible :beginDate, :endDate, :name, :brand_id
  validates :name, :presence => { :message => " digite um nome"}
  validates :beginDate, :presence => { :message => "digite a data inicial"}
  validates :endDate, :presence => { :message => "digite a data final"}
  has_many :sales

end
