class CreateLandAuthorizations < ActiveRecord::Migration
  def change
    create_table :land_authorizations do |t|
      t.integer :region_id, null: false

      t.references :authorizee, polymorphic: true, index: { name: 'index_land_authorizations_on_authorizee'}

      t.timestamps null: false
    end
    add_index :land_authorizations, :region_id
  end
end
