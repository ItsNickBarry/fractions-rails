json.current_character_government_authorizations do
  if current_character

    # TODO this is a bit off
    json.executable authorizer.authorizes?(current_character, :execute).map { |government_authorization| government_authorization.authorization_type }.to_a.uniq
    # , :execute do |government_authorization|
    #   json.executable government_authorization.authorization_type
    # end

    json.executable

    json.callable do
      # TODO electorate-vote-callable authorizations
    end

    json.votable do
      # TODO electorate-vote-noncallable authorizations
    end
  else
    json.executable []
    json.callable []
    json.votable []
  end
end
