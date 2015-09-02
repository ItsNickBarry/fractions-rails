class Api::SessionsController < ApplicationController

  def show
    @current_user = current_user || User.new
    @current_character = current_character
  end
end
