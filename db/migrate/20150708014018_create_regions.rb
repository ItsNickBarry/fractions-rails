class CreateRegions < ActiveRecord::Migration
  def change
    create_table :regions do |t|
      t.integer :fraction_id, null: false

      t.string :name, null: false

      t.timestamps null: false
    end
    add_index :regions, [:name, :fraction_id], unique: true
    add_index :regions, :fraction_id
  end
end
