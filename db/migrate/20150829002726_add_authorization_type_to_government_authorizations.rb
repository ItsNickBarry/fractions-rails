class AddAuthorizationTypeToGovernmentAuthorizations < ActiveRecord::Migration
  def change
    add_column :government_authorizations, :authorization_type, :string
    change_column :government_authorizations, :authorization_type, :string, null: false
  end
end
