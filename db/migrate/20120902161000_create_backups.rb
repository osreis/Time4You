class CreateBackups < ActiveRecord::Migration
  def change
    create_table :backups do |t|
      t.date :date
      t.string :file

      t.timestamps
    end
  end
end
