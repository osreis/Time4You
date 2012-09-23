class Order < ActiveRecord::Base
  belongs_to :user
  attr_accessible :amout, :consumerAmout, :created, :discount, :paymentType, :status, :updated, :user_id
  has_many :ordercells
  
   Order::STATUS_NEW = "new"
   Order::STATUS_CANCELED = "canceled"
   Order::STATUS_NEEDSPAYMENT = "payment"
   Order::STATUS_CONFIRMED= "confirmed"

end
