class Odeiosqlite3 < ActiveRecord::Migration
  def up
   drop_table :orders_payment_types
   create_table :orders_payment_types, :id => false do |t|
	t.references :orders
	t.references :payment_types
	t.column :order_id, :integer
	t.column :payment_type_id, :integer
	end
  end

  def down
  end
end
