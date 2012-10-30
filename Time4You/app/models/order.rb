class Order < ActiveRecord::Base
  belongs_to :user
  attr_accessible :amount, :consumerAmount, :created, :discount, :status, :updated, :user_id, :costPrice
  has_many :ordercells
  has_and_belongs_to_many  :payment_types
   Order::STATUS_NEW = "NOVA"
   Order::STATUS_CANCELED = "CANCEL"
   Order::STATUS_NEEDSPAYMENT = "PAG"
   Order::STATUS_CONFIRMED= "CONF"

end
