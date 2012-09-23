class Ordercell < ActiveRecord::Base
  belongs_to :order
  attr_accessible :quantity, :product_id
  has_one :product
end
