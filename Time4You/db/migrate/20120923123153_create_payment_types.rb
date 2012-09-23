class CreatePaymentTypes < ActiveRecord::Migration
  def change
    create_table :payment_types do |t|
      t.string :type
      t.decimal :discount
      t.references :order

      t.timestamps
    end
    add_index :payment_types, :order_id
  end
end
