class Product < ActiveRecord::Base
  attr_accessible :barcode, :brand_id, :in_stock_quantity, :name, :order_id, :regular_purchase_price, :regular_sale_price, :order_id
  validates_presence_of :name
  validates_presence_of :barcode
  validates_presence_of :regular_purchase_price
  validates_presence_of :regular_sale_price
  validates_presence_of :in_stock_quantity
  validates_numericality_of :in_stock_quantity, :greater_than => 0
  validates_presence_of :brand_id
  belongs_to :order
end
