class Salecell < ActiveRecord::Base
  belongs_to :ordercell
  attr_accessible :quantity
  has_and_belongs_to_many :special_products
  
end
