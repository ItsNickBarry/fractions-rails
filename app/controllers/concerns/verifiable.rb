module Verifiable
  extend ActiveSupport::Concern

  included do
    before_action :verify_params!, only: [:create]
  end

  private

    def verify_params!
      profile = MojangApiConnection.get_profile_given_username(user_params[:username])
      if profile.is_a? Hash
        @verified_params = user_params.merge(profile)
      else
        @user = User.new(user_params)
        flash.now[:errors] = [profile]
        render :new
      end
    end

    def user_params
      params.require(:user).permit(:username, :password)
    end
end
