class CreateCatalogs < ActiveRecord::Migration
  def change
    create_table :catalogs do |t|
      t.string :name
      t.date :endDate
      t.date :beginDate
      t.references :brand

      t.timestamps
    end
    add_index :catalogs, :brand_id
  end
end
