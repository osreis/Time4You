class Correcoes2 < ActiveRecord::Migration
  def up
      remove_column :payment_types, :type
	  remove_column :orders, :amout
	  remove_column :orders, :consumerAmout

  end

  def down
  	  remove_column :payment_types, :type
	  remove_column :orders, :amout
	  remove_column :orders, :consumerAmout

  end
end
