class CreateFractionInvitations < ActiveRecord::Migration
  def change
    create_table :fraction_invitations do |t|
    t.integer :character_id, null: false
      t.integer :fraction_id, null: false

      t.timestamps null: false
    end
    add_index :fraction_invitations, [:character_id, :fraction_id], unique: true
    add_index :fraction_invitations, :fraction_id
  end
end
