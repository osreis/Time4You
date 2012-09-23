class Correcoes < ActiveRecord::Migration
  def up
      add_column :orders, :amount, :decimal
	  add_column :orders, :consumerAmount, :decimal
	  add_column :payment_types, :name, :string
  end

  def down
	  remove_column :orders, :amout, :decimal
	  remove_column :orders, :consumerAmout, :decimal
  end
end
