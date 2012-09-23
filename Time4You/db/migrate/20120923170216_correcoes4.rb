class Correcoes4 < ActiveRecord::Migration
  def up
  	  add_column :orders, :costPrice, :decimal
  end

  def down
  end
end
