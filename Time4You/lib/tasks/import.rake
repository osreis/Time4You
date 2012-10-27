desc "Imports a CSV file into an ActiveRecord table"
task :csv_model_import, :filename, :model, :needs => :environment do |task,args|
  lines = File.new(args[:filename]).readlines
  header = lines.shift.strip
  keys = header.split(';')
  lines.each do |line|
    params = {}
    values = line.strip.split(';')
    keys.each_with_index do |key,i|
      params[key] = values[i]
	  #puts "key  - " + key.to_s
	  #puts "value" + values[i].to_s
    end
	 #puts "+++" + Molestia.create(:CodigoOms => values[0], :Titulo => values[1])
	 p = Product.new
	 p.barcode = values[0]
	 p.name = values[1]
	 p.regular_sale_price = values[2].to_f
	 p.regular_purchase_price = values[2].to_f
	p.in_stock_quantity = values[3].to_i
	 if p.save
		puts "****salvo!"
	else
		puts "++++ erro - " + p.to_json
		end
  end
end


#rake csv_model_import[produtos.csv,Product]