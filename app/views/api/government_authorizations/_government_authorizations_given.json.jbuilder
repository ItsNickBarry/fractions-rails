json.government_authorizations_given authorizer.government_authorizations_given do |authorization|
  json.extract! authorization, :id, :authorization_type
  json.authorizee do
    json.extract! authorization.authorizee, :id, :name
    json.type authorization.authorizee_type
  end
end
