json.government_authorizations_given authorizer.government_authorizations_given do |authorization|
  json.extract! authorization, :authorization_type
  json.authorizee do
    json.extract! authorization.authorizee, :id, :name
    json.type authorization.authorizee_type
  end
  json.authorizer do
    json.extract! authorization.authorizer, :id, :name
    json.type authorization.authorizer_type
  end
end
