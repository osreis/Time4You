class Ordercell < ActiveRecord::Base
  belongs_to :order
  attr_accessible :quantity, :product_id, :product_sold_price
  has_and_belongs_to_many :products
  has_many :salecells
  
end
