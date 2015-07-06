module Api
  class CharactersController < ApiController
    before_action :must_be_signed_in, except: [:show, :index]
    before_action :find_or_initialize_character, except: [:create, :index]

    def create
      @character = current_user.characters.new(character_params);
      if @character.save
        render json: @character
      else
        render json: @character.errors.full_messages, status: 422
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
end
