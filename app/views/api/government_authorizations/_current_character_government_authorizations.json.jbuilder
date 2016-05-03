json.current_character_government_authorizations do
  if current_character
    # TODO Governable method to get only the unique list of authorization_types
    json.executable authorizer.authorizations_for(current_character, :execute).map { |government_authorization| government_authorization.authorization_type }.uniq
    json.callable   authorizer.authorizations_for(current_character, :call   ).map { |government_authorization| government_authorization.authorization_type }.uniq
    json.votable    authorizer.authorizations_for(current_character, :vote   ).map { |government_authorization| government_authorization.authorization_type }.uniq

    # TODO current Ballots in progress
  else
    json.executable []
    json.callable []
    json.votable []
  end
end
