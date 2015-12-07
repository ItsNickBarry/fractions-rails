module Verifiable
  extend ActiveSupport::Concern

  included do
    before_action :verify_params!, only: [:create]
  end

  private

    def verify_params!
      response = MojangApiConnection.get_profile_given_username(user_params[:username])
      if response.is_a? Hash
        @verified_params = user_params.merge(response)
      else
        @user = User.new(user_params)
        flash.now[:errors] = [response]
        render :new
      end
    end

    def user_params
      params.require(:user).permit(:username, :password)
    end
end
