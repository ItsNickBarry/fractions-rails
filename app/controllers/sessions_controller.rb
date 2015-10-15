class SessionsController < ApplicationController
  include Verifiable

  before_action :must_not_be_signed_in, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    # TODO rate-limit login requests, maybe on MojangApiConnection
    @user = User.find_by_credentials(@verified_params)
    if @user
      if @user.username != @verified_params[:username]
        # TODO test username update
        @user.update_attributes({ username: @verified_params[:username] })
        flash.now[:errors] = ["Your username appears to have changed; you are now logged in as #{ @user.username }"]
      end
      sign_in! @user
      redirect_to root_url
    else
      @user = User.new(@verified_params)
      flash.now[:errors] = ["The combination of username and password you have provided is invalid."]
      render :new
    end
  end

  def destroy
    sign_out!
    redirect_to root_url
  end
end
