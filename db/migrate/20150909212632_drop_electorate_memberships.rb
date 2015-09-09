class DropElectorateMemberships < ActiveRecord::Migration
  def change
    drop_table :electorate_memberships
  end
end
