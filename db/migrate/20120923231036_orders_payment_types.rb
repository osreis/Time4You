class OrdersPaymentTypes < ActiveRecord::Migration
  def up
	create_table :orders_payment_types, :id => false do |t|
	t.references :orders, :null => false
	t.references :payment_types, :null => false
	end
  end

  def down
  end
end
