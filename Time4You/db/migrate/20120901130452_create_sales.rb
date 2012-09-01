class CreateSales < ActiveRecord::Migration
  def change
    create_table :sales do |t|
      t.decimal :salePrice
      t.references :product
      t.references :catalog

      t.timestamps
    end
    add_index :sales, :product_id
    add_index :sales, :catalog_id
  end
end
