require 'open-uri'

class MojangApiConnection

  def self.get_profile_given_username(username)
    response = open(profile_url(username))

    rescue
      "Cannot communicate with Mojang server"
    else
      if response.status[0] == '200'
        parse(response)
      elsif response.status[0] == '204'
        "Not a Minecraft username: #{ username }"
      else
        "Mojang server returned unexpected status code #{ response.status[0] }"
      end
  end

  def self.profile_url(username)
    "https://api.mojang.com/users/profiles/minecraft/#{ username }"
  end

  private

    def self.parse(response)
      json = JSON.parse(response.string)
      { 'username' => json['name'], 'uuid' => json['id'] }
    end
end
