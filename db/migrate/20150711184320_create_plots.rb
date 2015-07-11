class CreatePlots < ActiveRecord::Migration
  def change
    create_table :plots do |t|
      t.integer :region_id
      t.integer :world_id, null: false

      t.integer :x, null: false
      t.integer :z, null: false

      t.timestamps null: false
    end
    add_index :plots, :region_id
    add_index :plots, [:world_id, :x, :z], unique: true
    add_index :plots, :x
    add_index :plots, :z
  end
end
