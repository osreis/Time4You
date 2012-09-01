class CreateBrands < ActiveRecord::Migration
  def change
    create_table :brands do |t|
      t.string :name
      t.string :representative_name
      t.string :representative_email
      t.string :representative_phone
      t.text :extra_info

      t.timestamps
    end
  end
end
