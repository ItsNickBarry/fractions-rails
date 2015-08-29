class AddAuthorizationTypeToLandAuthorizations < ActiveRecord::Migration
  def change
    add_column :land_authorizations, :authorization_type, :string
    change_column :land_authorizations, :authorization_type, :string, null: false
  end
end
