class Api::PositionsController < ApplicationController
  before_action :must_be_signed_in, except: [:show, :index]
  before_action :find_or_initialize_position, except: [:create, :index]

  def create
    @fraction = Fraction.find(params[:fraction_id])
    @position = @fraction.positions.new(position_params)

    unless @fraction.authorizes? current_character, :execute, :position_create
      render json: "#{ @fraction.name } does not authorize #{ current_character.name } to create positions", status: 422
      return
    end

    # TODO complex position initialization, including authorizations
    if @position.save
      render :show
    else
      render json: @position.errors.full_messages, status: 422
    end
  end

  def show
  end

  private

    def position_params
      params.require(:position).permit(:name)
    end

    def find_or_initialize_position
      @position = params[:id] ? Position.find(params[:id]) : Position.new
    end
end
