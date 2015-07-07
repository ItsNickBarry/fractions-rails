class CreatePositionMemberships < ActiveRecord::Migration
  def change
    create_table :position_memberships do |t|
      t.integer :character_id, null: false
      t.integer :position_id, null: false

      t.timestamps null: false
    end
    add_index :position_memberships, [:character_id, :position_id], unique: true
    add_index :position_memberships, :position_id
  end
end
