class CreateGovernmentAuthorizations < ActiveRecord::Migration
  def change
    create_table :government_authorizations do |t|
      t.references :authorizer, polymorphic: true, index: { name: 'index_government_authorizations_on_authorizer'}
      t.references :authorizee, polymorphic: true, index: { name: 'index_government_authorizations_on_authorizee'}

      t.timestamps null: false
    end
  end
end
