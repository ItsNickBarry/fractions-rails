class Api::PositionsController < ApplicationController
  before_action :must_be_signed_in, only: [:create]
  before_action :must_have_current_character, only: [:create]

  def create
    @fraction = Fraction.find(params[:fraction_id])
    @position = @fraction.positions.new(position_params)

    unless @fraction.authorizes? current_character, :execute, :position_create
      render json: ["#{ @fraction.name } does not authorize #{ current_character.name } to create positions"], status: 403
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
    @position = Position.find(params[:id])
  end

  private

    def position_params
      params.require(:position).permit(:name)
    end
end
