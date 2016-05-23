class Api::CharactersController < ApplicationController
  before_action :must_be_signed_in, only: [:create]

  def create
    unless current_user.can_create_character?
      render json: "#{ current_user.username } cannot create a character", status: 403
      return
    end

    @character = current_user.characters.new(character_params);
    if @character.save
      render :show
    else
      render json: @character.errors.full_messages, status: 422
    end
  end

  def show
    @character = Character.find(params[:id])
  end

  private

    def character_params
      params.require(:character).permit(:name, :gender)
    end
end
