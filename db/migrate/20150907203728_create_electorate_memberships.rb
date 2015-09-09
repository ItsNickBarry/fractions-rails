class CreateElectorateMemberships < ActiveRecord::Migration
  def change
    create_table :electorate_memberships do |t|

      # note: this table is dropped in the next migration, and recreated later
      
      t.references :member, polymorphic: true, null: false
      t.references :electorate, null: false

      t.timestamps null: false
    end
    add_index :electorate_memberships, [:member_type, :member_id, :electorate_id], unique: true, name: 'index_electorate_memberships_uniquely'
  end
end
