class CreateSpecialProducts < ActiveRecord::Migration
  def change
    create_table :special_products do |t|
      t.integer :total
	  t.integer :available
      t.decimal :specialPrice
      t.references :product

      t.timestamps
    end
    add_index :special_products, :product_id
  end
end
