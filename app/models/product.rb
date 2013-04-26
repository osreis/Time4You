class Product < ActiveRecord::Base
  attr_accessible :barcode, :brand_id, :in_stock_quantity, :name, :order_id, :regular_purchase_price, :regular_sale_price, :order_id
  validates_presence_of :name
  validates_presence_of :barcode
  validates_presence_of :regular_purchase_price
  validates_presence_of :regular_sale_price
  validates_presence_of :in_stock_quantity
  #validates_numericality_of :in_stock_quantity, :greater_than => 0
  validates_presence_of :brand_id
  has_and_belongs_to_many :ordercells
  belongs_to :brand
  has_one :sale
  
  def self.searchByBarcode(barcode)
    if (barcode)
      Product.where('barcode = ?', barcode)
    else
      Product.all
    end   
  end

  def self.searchByName(name)
    if (name)
      Product.where('name like ?', "%#{name}%")
    else
      Product.all
    end
  end 
  
  def self.searchByPage(page)
    paginate :per_page => 5, :page => page
  end

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |product|
        csv << product.attributes.values_at(*column_names)
      end
    end
  end
end
