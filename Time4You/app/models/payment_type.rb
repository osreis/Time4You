class PaymentType < ActiveRecord::Base
  has_and_belongs_to_many :orders
  attr_accessible :discount, :name
end
