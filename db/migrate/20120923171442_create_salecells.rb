class CreateSalecells < ActiveRecord::Migration
  def change
    create_table :salecells do |t|
      t.integer :quantity
      t.references :ordercell

      t.timestamps
    end
    add_index :salecells, :ordercell_id
	add_column :special_products, :salecell_id, :integer
	add_index :special_products, :salecell_id
	add_column :ordercells, :product_sold_price, :decimal

  end
end
