#  This file should contain all the record creation needed to seed the database with its default values.
#  The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
# 
#  Examples:
# 
#    cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#    Mayor.create(name: 'Emanuel', city: cities.first)

PaymentType.find_or_create_by_name("Dinheiro", discount: 20.0)

if Group.count == 0
	puts "Criando Grupo de Administracao"
		group_administracao = Group.create(:name => 'Administradores', :internal_id => Group::ADMIN.to_i)
		group_vendas = Group.create(:name => 'Vendedores', :internal_id => Group::VENDEDOR.to_i)
	puts "Grupo de Administracao criado com sucesso"
end

if User.count == 0
	puts "Criando Usuario Administrador"
	user = User.create(:name => 'Eluísa', login: 'elu', :password => '12345678', :password_confirmation => '12345678')
	user.group = group_administracao
	if user.save
		puts "Usuario administrador criado com sucesso! -> login: elu, senha: 12345678"
	else
		puts "*****nao foi possivel criar um usuario, por favor execute db:seed novamente"
	end
end	







