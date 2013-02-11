class CreateCashiers < ActiveRecord::Migration
  def up
  	create_table :cashiers do |t|
      t.decimal :initial_amount
      t.date :opened
      t.date :closed
      t.timestamps
    end
  end

  def down
  end
end
