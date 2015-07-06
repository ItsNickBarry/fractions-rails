class CreateBanishments < ActiveRecord::Migration
  def change
    create_table :banishments do |t|
      t.integer :character_id, null: false
      t.integer :fraction_id, null: false

      t.timestamps null: false
    end
    add_index :banishments, [:character_id, :fraction_id], unique: true
    add_index :banishments, :fraction_id
  end
end
