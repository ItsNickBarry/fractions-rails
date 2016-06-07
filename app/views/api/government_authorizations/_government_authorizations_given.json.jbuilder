if current_character
  current_character_government_authorizations = (
    authorizer.authorizations_for(current_character, :execute) +
    authorizer.authorizations_for(current_character, :call) +
    authorizer.authorizations_for(current_character, :vote)
  ).map { |authorization| authorization.id }.sort
else
  current_character_government_authorizations = []
end

json.government_authorizations_given authorizer.government_authorizations_given do |authorization|
  json.extract! authorization, :id, :authorization_type
  json.current_character !current_character_government_authorizations.bsearch { |id| id >= authorization.id }.nil?
  json.authorizee do
    # TODO find authorizees in a single query
    json.id authorization.authorizee_id
    json.extract! authorization.authorizee, :name
    json.type authorization.authorizee_type
  end
end
