class Api::ElectoratesController < ApplicationController
  before_action :must_be_signed_in, only: [:create]
  before_action :must_have_current_character, only: [:create]

  def create
    @fraction = Fraction.find(params[:fraction_id])
    @electorate = @fraction.electorates.new(electorate_params)

    unless @fraction.authorizes? current_character, :execute, :electorate_create
      render json: "#{ @fraction.name } does not authorize #{ current_character.name } to create electorates", status: 403
      return
    end

    # TODO complex electorate initialization, including authorizations
    if @electorate.save
      render :show
    else
      render json: @electorate.errors.full_messages, status: 422
    end
  end

  def show
    @electorate = Electorate.find(params[:id])
  end

  private

    def electorate_params
      params.require(:electorate).permit(:name)
    end
end
