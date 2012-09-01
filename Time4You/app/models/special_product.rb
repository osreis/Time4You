class SpecialProduct < ActiveRecord::Base
  belongs_to :product
  attr_accessible :total, :specialPrice, :available, :product_id
  validates :specialPrice, :presence => { :message => "digite o preço especial." }
  validates :total, :presence => { :message => "digite o total" }
  validates :available, :presence => { :message => "digite o total disponível" }

end
