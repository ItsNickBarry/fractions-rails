class SessionsController < ApplicationController

  before_action :must_not_be_signed_in, only: [:new, :create]
  before_action :must_be_signed_in, only: [:destroy]

  def new
    @user = User.new
  end

  def create
    response = MojangApiConnection.profile_given_username(user_params[:username])
    if response.is_a? Hash
      @user = User.find_by_credentials(response[:uuid], user_params[:password])
      if @user
        if @user.username != response[:username]
          @user.update_attributes(username: response[:username])
          flash[:notice] = ["Your username appears to have changed; you are now signed in as #{ @user.username }."]
        end
        sign_in! @user
        redirect_to root_url
      else
        @user = User.new(user_params)
        flash.now[:errors] = ["The combination of username and password you have provided is invalid."]
        render :new
      end
    else
      @user = User.new(user_params)
      flash.now[:errors] = [response]
      render :new
    end
  end

  def destroy
    sign_out!
    redirect_to root_url
  end

  private

    def user_params
      params.require(:user).permit(:username, :password)
    end
end
