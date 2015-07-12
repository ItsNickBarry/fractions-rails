class Api::CharactersController < ApplicationController
  before_action :must_be_signed_in, except: [:show, :index]
  before_action :find_or_initialize_character, except: [:create, :index]

  def create
    @character = current_user.characters.new(character_params);
    if @character.save
      render :show
    else
      render @character.errors.full_messages, status: 422
    end
  end

  def show
  end

  private

    def character_params
      params.require(:character).permit(:name, :gender)
    end

    def find_or_initialize_character
      @character = params[:id] ? Character.find(params[:id]) : Character.new
    end
end
