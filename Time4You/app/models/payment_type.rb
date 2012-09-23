class PaymentType < ActiveRecord::Base
  belongs_to :order
  attr_accessible :discount, :name
end
