class SessionsController < ApplicationController
  before_action :must_not_be_signed_in, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    # TODO rate-limit login requests
    @user = User.find_by_credentials(session_params)
    if @user
      if @user.username == session_params[:username]
        sign_in! @user
        redirect_to root_url
      else
        flash.now[:errors] = ["Your username appears to have changed; please log in to the server to update your information."]
        render :new
      end
    else
      @user = User.new
      flash.now[:errors] = ["The combination of username and password you have provided is invalid."]
      render :new
    end
  end

  def destroy
    sign_out!
    redirect_to new_session_url
  end

  private

    def session_params
      params.require(:user).permit(:username, :uuid, :password)
    end
end
