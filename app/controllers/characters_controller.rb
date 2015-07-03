class CharactersController < ApplicationController
  before_action :must_be_signed_in, except: [:show, :index]
  before_action :find_or_initialize_character, except: [:create, :index]

  def show
  end

  def index
    # TODO pagination, search
    @characters = Character.all
  end

  private

    def character_params
      params.require(:character).permit(:name, :gender)
    end

    def find_or_initialize_character
      @character = params[:id] ? Character.find(params[:id]) : Character.new
    end
end
