class MojangApiConnection

  def self.profile_given_name(name)
    Rails.cache.fetch(profile_url(name.downcase), expires_in: 5.minutes) do
      query_profile_given_name(name)
    end
  end

  private

    def self.query_profile_given_name(name)
      return invalid_name(name) unless valid_name? name

      response = Curl::Easy.perform(profile_url(name))
      rescue
        communication_error
      else
        if response.response_code == 200
          parse_profile(response)
        elsif response.response_code == 204
          invalid_name(name)
        else
          unexpected_status_code(response)
        end
    end

    def self.profile_url(name)
      "https://api.mojang.com/users/profiles/minecraft/#{ name.downcase }"
    end

    # def self.name_history_url(uuid)
    #   "https://api.mojang.com/user/profiles/#{ uuid }/names"
    # end

    def self.parse_profile(response)
      json = JSON.parse(response.body)
      { name: json['name'], uuid: json['id'] }
    end

    def self.valid_name?(name)
      /\A[a-zA-Z0-9_]{4,16}\z/ === name
    end

    def self.communication_error
      "Cannot communicate with the Mojang server"
    end

    def self.invalid_name(name)
      "Not a Minecraft name: #{ name }"
    end

    def self.unexpected_status_code(response)
      "Mojang server returned unexpected status code #{ response.response_code }"
    end
end
