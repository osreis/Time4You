class AddCommissionToUser < ActiveRecord::Migration
  def change
  	add_column :users, :commission, :decimal
  end
end
