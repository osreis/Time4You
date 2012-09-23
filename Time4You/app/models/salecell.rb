class Salecell < ActiveRecord::Base
  belongs_to :ordercell
  attr_accessible :quantity
  has_one :special_product
  
end
