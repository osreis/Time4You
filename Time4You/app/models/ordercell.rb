class Ordercell < ActiveRecord::Base
  belongs_to :order
  attr_accessible :quantity, :product_id, :product_sold_price
  has_one :product
  has_many :salecells
  
end
