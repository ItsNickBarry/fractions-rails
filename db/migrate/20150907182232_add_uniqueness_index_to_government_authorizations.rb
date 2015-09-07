class AddUniquenessIndexToGovernmentAuthorizations < ActiveRecord::Migration
  def change
    add_index :government_authorizations, [:authorizer_type, :authorizer_id, :authorizee_type, :authorizee_id, :authorization_type],
      unique: true, name: 'index_government_authorizations_uniquely'

    remove_index :government_authorizations, name: 'index_government_authorizations_on_authorizer'
    remove_index :government_authorizations, name: 'index_government_authorizations_on_authorizee'
  end
end
