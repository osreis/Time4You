class Ordercell < ActiveRecord::Base
  belongs_to :order
  attr_accessible :quantity
  has_one :product
end
