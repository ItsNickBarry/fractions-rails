json.extract! @electorate, :id, :name, :created_at

json.fraction do
  json.extract! @electorate.fraction, :id, :name
end

json.members @electorate.members do |member|
  json.extract! member, :id, :name
end

json.partial! 'api/government_authorizations/government_authorizations_given', authorizer: @electorate
