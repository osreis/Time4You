# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#puts "Removendo usuarios..."
#User.destroy_all
#puts "Usuarios removidos com sucesso"
#puts "Removendo groups..."
#Group.destroy_all
#puts "Grupos removidos com sucesso"

#puts "Criando Grupo de Administracao"
#	group_administracao = Group.create(:name => 'Administradores', :internal_id => Group::ADMIN.to_i)
#	group_vendas = Group.create(:name => 'Vendedores', :internal_id => Group::VENDEDOR.to_i)
#puts "Grupo de Administracao criado com sucesso"	

#puts "Criando Usuario Administrador"
#	user = User.create(:name => 'Administrador ', :email => 'admin@gmail.com', :password => '1234', :password_confirmation => '1234')
#	user.group = group_administracao
#	if user.save
#	puts "Usuario administrador criado com sucesso! -> login: admin@gmail.com, senha: 1234"
#else
#	puts "*****nao foi possivel criar um usuario, por favor execute db:seed novamente"
#end
Order.destroy_all
#PaymentType.destroy_all
#puts "*****nao foi possivel criar um usuario, por favor execute db:seed novamente"
#payment = PaymentType.create(:name =>  "Cartão de Crédito", :discount => 15.00 )
#payment = PaymentType.create(:name =>  "Cartão de Débito", :discount => 20.00 )
#payment = PaymentType.create(:name =>  "Dinheiro", :discount => 20.00 )
Sale.destroy_all
SpecialProduct.destroy_all
Product.destroy_all
@produto1 = Product.create(:name => "teste1", :barcode => 1, :regular_purchase_price => 10.00, :regular_sale_price => 7.00, :in_stock_quantity => 20, :brand_id => Brand.all.first.id )
@produto12= Product.create(:name => "teste2", :barcode => 2, :regular_purchase_price => 12.00, :regular_sale_price => 5.00, :in_stock_quantity => 20, :brand_id => Brand.all.first.id )
@produto123= Product.create(:name => "teste23", :barcode => 3, :regular_purchase_price => 13.00, :regular_sale_price => 5.00, :in_stock_quantity => 20, :brand_id => Brand.all.first.id )
@sale1 = Sale.create(:product_id => @produto1.id, :salePrice => 2.00, :catalog_id => Catalog.all.first.id)
@sale2 = Sale.create(:product_id => @produto12.id, :salePrice => 2.00, :catalog_id => Catalog.all.last.id)
@special = SpecialProduct.create(:total => 2, :available => 2, :specialPrice => 1.0, :product_id => @produto1.id)






