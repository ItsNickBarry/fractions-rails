json.government_authorizations_given @government_authorizations_given.map do |authorization|
  json.extract! authorization, :authorization_type
  json.authorizee do
    json.extract! authorization.authorizee, :id, :name
    json.type authorization.authorizee_type
  end
end

if @government_authorizations_received
  json.government_authorizations_received @government_authorizations_received.map do |authorization|
    json.extract! authorization, :authorization_type
    json.authorizer do
      json.extract! authorization.authorizer, :id, :name
      json.type authorization.authorizer_type
    end
  end
end
