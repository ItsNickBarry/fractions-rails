class RecreateElectorateMemberships < ActiveRecord::Migration
  def change
    create_table :electorate_memberships do |t|
      t.references :electorate, null: false
      t.references :position, null: false

      t.boolean :caller, null: false, default: false
      t.boolean :electoral, null: false, default: false
      t.boolean :absolute, null: false, default: false

      t.float :weight, null: false, default: 1

      t.timestamps null: false
    end
    add_index :electorate_memberships, [:electorate_id, :position_id], unique: true, name: 'index_electorate_memberships_uniquely'
  end
end
