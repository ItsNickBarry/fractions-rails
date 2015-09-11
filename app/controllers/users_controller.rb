require 'open-uri'

class UsersController < ApplicationController
  before_action :must_not_be_signed_in, only: [:new, :create]

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(user_params)
    mojang_api_url = "https://api.mojang.com/users/profiles/minecraft/#{ @user.username }"
    mojang_api_response = JSON.parse(open(mojang_api_url).string)

    @user.username = mojang_api_response["name"]
    @user.uuid = mojang_api_response["id"]

    if @user.save
      # TODO display activation instructions
      # sign_in!(@user)
      # redirect_to @user
      redirect_to root_url
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  private

    def user_params
      params.require(:user).permit(:username, :password)
    end
end
