json.extract! @government_authorization, :id, :authorization_type

json.authorizer do
  json.extract! @government_authorization.authorizer, :id, :name
  json.type @government_authorization.authorizer_type
end

json.authorizee do
  json.extract! @government_authorization.authorizee, :id, :name
  json.type @government_authorization.authorizee_type
end
