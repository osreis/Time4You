class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :name
      t.string :password_digest
      t.string :address
      t.string :phone
      t.date :birthDate
      t.string :cpf
      t.string :login
      t.string :mobile
      t.string :gender
      t.string :city
      t.string :state
      t.string :cep
      t.references :group

      t.timestamps
    end
    add_index :users, :group_id
  end
end
