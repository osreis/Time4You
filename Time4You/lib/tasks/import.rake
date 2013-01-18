require 'csv'

namespace :import do 
	desc "Import data from CSV file"
	task csv: :environment do
		puts 'Importando dados do arquivo .csv. Por favor, aguarde...'
		natura	= Brand.find_or_create_by_name("Natura")
		avon 	= Brand.find_or_create_by_name("Avon")
		jequiti = Brand.find_or_create_by_name("Jequiti")
		vult 	= Brand.find_or_create_by_name("Vult")
		duda 	= Brand.find_or_create_by_name("Duda")
		ubu 	= Brand.find_or_create_by_name("UBU")
		qvs 	= Brand.find_or_create_by_name("QVS")
		oceane 	= Brand.find_or_create_by_name("Oceane")
		CSV.foreach("t4y.CSV") do |row|
			p = Product.new
			p.barcode = row[0];
			case row[1].to_i
			when 1 then p.brand_id = natura.id
			when 2 then p.brand_id = avon.id
			when 3 then p.brand_id = jequiti.id
			when 4 then p.brand_id = vult.id
			when 5 then p.brand_id = duda.id
			when 6 then p.brand_id = ubu.id
			when 7 then p.brand_id = qvs.id
			when 8 then p.brand_id = oceane.id
			end

			p.name 						= row[2];
			p.regular_purchase_price 	= 0.0
			p.regular_sale_price 		= row[3].blank? ? 0.0 : row[3].gsub(",",".").to_f
			p.in_stock_quantity 		= row[4]

			if !p.save
				puts p.errors.messages
			end
		end
	end
end