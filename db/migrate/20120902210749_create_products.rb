class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.string :barcode
      t.string :regular_purchase_price
      t.string :regular_sale_price
      t.integer :in_stock_quantity
      t.integer :brand_id
      t.integer :order_id

      t.timestamps
    end
  end
end
