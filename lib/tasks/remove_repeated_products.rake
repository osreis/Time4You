namespace :remove do 
	desc "Removes repeated elements"
	task repeated_products: :environment do
		puts 'Removendo produtos repetidos'
		count = 0
		Product.all.each do |p|
			products = Product.where(barcode: p.barcode)
			if products.size > 1
				products.delete(products.first)
				products.each do |repeated_product|
					db_product = Product.find(repeated_product.id)
					db_product.destroy
					count += 1
				end
			end
		end
		puts "#{count} produtos foram removidos"
	end
end