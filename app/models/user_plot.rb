class UserPlot

  def initialize(params)
    @user = User.find_by(uuid: params[:uuid])
    @plot = Plot.find_by(world: params[:world], x: params[:x], z: params[:z])
  end

  def authorizations
    if @plot && @plot.region_id
      unless @user && @user.current_character_id
        # block all actions by unregistered users on owned plots
        return []
      end
    else
      # allow all actions on un-owned plots
      return LandAuthorization.types
    end

    Rails.cache.fetch(cache_key) do
      query
    end
  end

  def cache_key
    # TODO touch plot on region/fraction name change
    # TODO touch character on perm change
    "#{ @user.current_character.cache_key }-#{ @plot.cache_key }"
  end

  private

    def query
      # TODO complex SQL to find land authorizations
      # select land_authorizations.authorization_type ...
    end
end
