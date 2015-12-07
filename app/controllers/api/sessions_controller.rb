class Api::SessionsController < ApplicationController

  before_action :must_be_signed_in, only: [:show]

  def show
    @current_user = current_user || User.new
    @current_character = current_character
  end
end
