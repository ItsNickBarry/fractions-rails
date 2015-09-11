class UsersController < ApplicationController
  before_action :must_not_be_signed_in, only: [:new, :create]

  def new
    @user = User.new
    render :new
  end

  def create
    verified_params = verify_params! user_params

    @user = User.new(verified_params)
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
