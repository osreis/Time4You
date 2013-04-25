class IndexTables < ActiveRecord::Migration
  def up
   change_table(:orders_payment_types) do |t|
   t.column :order_id, :integer, :default => "something"
   t.column :payment_type_id, :integer, :default => "something"
   end 
  end

  def down
  end
end
