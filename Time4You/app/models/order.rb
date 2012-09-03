class Order < ActiveRecord::Base
  belongs_to :user
  attr_accessible :amout, :consumerAmout, :created, :discount, :paymentType, :status, :updated, :user_id
  has_many :products
end
