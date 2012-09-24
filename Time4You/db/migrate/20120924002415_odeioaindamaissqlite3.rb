class Odeioaindamaissqlite3 < ActiveRecord::Migration
  def up
  
   create_table :ordercells_products, :id => false do |t|
	t.references :ordercells
	t.references :products
	t.column :ordercell_id, :integer
	t.column :product_id, :integer
  end
  
   create_table :salecells_special_products, :id => false do |t|
	t.references :salecells
	t.references :special_products
	t.column :salecell_id, :integer
	t.column :special_product_id, :integer
  end
  
end
  
  
  def down
  end
end
