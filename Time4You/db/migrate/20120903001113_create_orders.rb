class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.date :created
      t.decimal :amout
      t.string :paymentType
      t.decimal :discount
      t.decimal :consumerAmout
      t.string :status
      t.date :updated
      t.references :user

      t.timestamps
    end
    add_index :orders, :user_id
	add_index :products, :order_id

  end
end
