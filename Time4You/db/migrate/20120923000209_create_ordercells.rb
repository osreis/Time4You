class CreateOrdercells < ActiveRecord::Migration
  def change
    create_table :ordercells do |t|
      t.integer :quantity
      t.references :order

      t.timestamps
    end
	add_column :products, :ordercell_id, :integer
    add_index :ordercells, :order_id
	add_index :products, :ordercell_id

  end
end
