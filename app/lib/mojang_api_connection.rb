require 'open-uri'

class MojangApiConnection

  def self.profile_given_username(username)
    return "Invalid Minecraft username: #{ username }" unless valid_username? username

    response = open(profile_url(username))
    rescue
      communication_error
    else
      if response.status[0] == '200'
        user_attributes_from_profile(response)
      elsif response.status[0] == '204'
        invalid_username(username)
      else
        unexpected_status_code(response)
      end
  end

  def self.profile_url(username)
    "https://api.mojang.com/users/profiles/minecraft/#{ username }"
  end

  # def self.name_history_url(uuid)
  #   "https://api.mojang.com/user/profiles/#{ uuid }/names"
  # end

  private

    def self.user_attributes_from_profile(response)
      json = JSON.parse(response.string)
      { username: json['name'], uuid: json['id'] }
    end

    def self.valid_username?(username)
      /\A[a-zA-Z0-9_]{4,16}\z/ === username
    end

    def self.communication_error
      "Cannot communicate with the Mojang server"
    end

    def self.invalid_username(username)
      "Not a Minecraft username: #{ username }"
    end

    def self.unexpected_status_code(response)
      "Mojang server returned unexpected status code #{ response.status[0] }"
    end
end
