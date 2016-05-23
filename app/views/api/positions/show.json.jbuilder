json.extract! @position, :id, :name, :created_at

json.fraction do
  json.extract! @position.fraction, :id, :name
end

json.members @position.members do |member|
  json.extract! member, :id, :name
end

json.partial! 'api/government_authorizations/current_character_government_authorizations', authorizer: @position
