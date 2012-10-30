class Sale < ActiveRecord::Base
  
  belongs_to :product
  belongs_to :catalog
  attr_accessible  :salePrice, :catalog_id, :product_id
  validates :salePrice, :presence => { :message => "digite o preço promocional." }
  #validate :brand

  def brand
    errors.add(:product, 'não pertence à mesma marca do catálogo') if self.product.brand != self.catalog.brand
  end

end
