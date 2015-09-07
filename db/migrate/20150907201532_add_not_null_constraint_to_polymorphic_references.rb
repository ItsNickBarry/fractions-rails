class AddNotNullConstraintToPolymorphicReferences < ActiveRecord::Migration
  def change
    change_column_null :fractions, :founder_id, false
    change_column_null :fractions, :founder_type, false
    change_column_null :government_authorizations, :authorizer_id, false
    change_column_null :government_authorizations, :authorizer_type, false
    change_column_null :government_authorizations, :authorizee_id, false
    change_column_null :government_authorizations, :authorizee_type, false
    change_column_null :land_authorizations, :authorizee_id, false
    change_column_null :land_authorizations, :authorizee_type, false
  end
end
