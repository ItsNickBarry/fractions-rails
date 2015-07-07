class CreatePositions < ActiveRecord::Migration
  def change
    create_table :positions do |t|
      t.integer :fraction_id, null: false

      t.string :name, null: false

      t.timestamps null: false
    end
    add_index :positions, [:name, :fraction_id], unique: true
    add_index :positions, :fraction_id
  end
end
