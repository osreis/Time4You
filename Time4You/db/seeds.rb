# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
puts "Removendo usuarios..."
User.destroy_all
puts "Usuarios removidos com sucesso"
puts "Removendo groups..."
Group.destroy_all
puts "Grupos removidos com sucesso"

puts "Criando Grupo de Administracao"
	group_administracao = Group.create(:name => 'Administradores', :internal_id => Group::ADMIN.to_i)
	group_vendas = Group.create(:name => 'Vendedores', :internal_id => Group::VENDEDOR.to_i)
puts "Grupo de Administracao criado com sucesso"	

puts "Criando Usuario Administrador"
	user = User.create(:name => 'Administrador ', :email => 'admin@gmail.com', :password => '1234', :password_confirmation => '1234')
	user.group = group_administracao
	if user.save
	puts "Usuario administrador criado com sucesso! -> login: admin@gmail.com, senha: 1234"
else
	puts "*****nao foi possivel criar um usuario, por favor execute db:seed novamente"
end

