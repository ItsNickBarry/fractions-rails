json.government_authorizations do
  if current_character
    json.executable authorizee.authorizes? current_character, :execute do |government_authorization|
      json.extract! government_authorization, :authorization_type
    end

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
