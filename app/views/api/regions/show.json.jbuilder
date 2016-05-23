json.extract! @region, :id, :name, :created_at

json.fraction do
  json.extract! @region.fraction, :id, :name
end

json.partial! 'api/government_authorizations/current_character_government_authorizations', authorizer: @region
