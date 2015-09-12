require 'open-uri'

class MojangApiConnection

  def self.get_profile_given_username(username)
    mojang_api_url = "https://api.mojang.com/users/profiles/minecraft/#{ username }"
    response = open(mojang_api_url)

    if response.status[0] == '200'
      json = JSON.parse(response.string)
      { 'username' => json['name'], 'uuid' => json['id'] }
    else
      nil
    end
  end
end
