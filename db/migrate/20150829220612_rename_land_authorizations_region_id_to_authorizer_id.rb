class RenameLandAuthorizationsRegionIdToAuthorizerId < ActiveRecord::Migration
  def change
    rename_column :land_authorizations, :region_id, :authorizer_id
  end
end
