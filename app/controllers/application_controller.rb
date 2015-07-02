class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user, :signed_in?

  def current_user
    return nil if session["session_token"].nil?
    @current_user ||= User.where(session_token: session["session_token"]).first
  end

  def signed_in?
    !!current_user
  end

  def sign_in!(user)
    user.reset_session_token!
    @current_user = user
    session["session_token"] = user.session_token;
  end

  def sign_out!
    current_user.reset_session_token! if current_user
    session["session_token"] = nil
  end

  def must_be_signed_in
    unless signed_in?
      # TODO display flash message
      redirect_to new_session_url
    end
  end

  def must_not_be_signed_in
    if signed_in?
      # TODO display flash message
      redirect_to root_url
    end
  end
end
