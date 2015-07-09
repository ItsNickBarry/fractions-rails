class CreateElectorates < ActiveRecord::Migration
  def change
    create_table :electorates do |t|
      t.integer :fraction_id, null: false

      t.string :name, null: false

      t.timestamps null: false
    end
    add_index :electorates, [:name, :fraction_id], unique: true
    add_index :electorates, :fraction_id
  end
end
