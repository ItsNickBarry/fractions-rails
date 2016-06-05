class SessionsController < ApplicationController
  before_action :must_not_be_signed_in, only: [:new, :create]
  before_action :must_be_signed_in, only: [:destroy]

  def new
    @user = User.new
  end

  def create
    response = MojangApiConnection.profile_given_name(user_params[:name])
    if response.is_a? Hash
      @user = User.find_by_credentials(response[:uuid], user_params[:password])
      if @user
        if @user.name != response[:name]
          @user.update_attributes(name: response[:name])
          flash[:notice] = ["Your name appears to have changed; you are now signed in as #{ @user.name }."]
        end
        sign_in! @user
        redirect_to root_url
      else
        @user = User.new(user_params)
        flash.now[:errors] = ["The combination of name and password you have provided is invalid."]
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
      params.require(:user).permit(:name, :password)
    end
end
