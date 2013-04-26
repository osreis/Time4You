class AssetController < ApplicationController
  def index
  	@asset 	= 0.0
  	@in_stock_quantity = 0
  	# @cost 	= 0.0
  	Product.all.each do |p|
  		@asset 	+= p.regular_sale_price.to_f
  		@in_stock_quantity += p.in_stock_quantity
  		# @cost	+= p.regular_purchase_price.to_f
  	end
  end
end
