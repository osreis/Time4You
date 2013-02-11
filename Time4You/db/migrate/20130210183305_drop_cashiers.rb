class DropCashiers < ActiveRecord::Migration
  def up
    drop_table :cashiers
  end

  def down
  end
end

