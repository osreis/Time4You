class Order < ActiveRecord::Base
  belongs_to :user
  attr_accessible :amount, :consumerAmount, :created, :discount, :status, :updated, :user_id
  has_many :ordercells
  has_one :payment_type
   Order::STATUS_NEW = "N"
   Order::STATUS_CANCELED = "D"
   Order::STATUS_NEEDSPAYMENT = "P"
   Order::STATUS_CONFIRMED= "C"

end
