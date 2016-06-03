class Api::RegionsController < ApplicationController
  before_action :must_be_signed_in, only: [:create]
  before_action :must_have_current_character, only: [:create]

  def create
    @fraction = Fraction.find(params[:fraction_id])
    @region = @fraction.regions.new(region_params)

    unless @fraction.authorizes? current_character, :execute, :region_create
      render json: ["#{ @fraction.name } does not authorize #{ current_character.name } to create regions"], status: 403
      return
    end

    # TODO complex region initialization, including authorizations
    if @region.save
      render :show
    else
      render json: @region.errors.full_messages, status: 422
    end
  end

  def show
    @region = Region.find(params[:id])
  end

  private

    def region_params
      params.require(:region).permit(:name)
    end
end
