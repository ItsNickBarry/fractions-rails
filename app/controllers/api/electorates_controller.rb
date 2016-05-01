class Api::ElectoratesController < ApplicationController
  before_action :must_be_signed_in, except: [:show, :index]
  before_action :find_or_initialize_electorate, except: [:create, :index]

  def create
    @fraction = Fraction.find(electorate_params[:fraction_id])
    @electorate = @fraction.electorates.new(electorate_params)

    unless @fraction.authorizes? current_character, :execute, :electorate_create
      render json: "#{ @fraction.name } does not authorize #{ current_character.name } to create electorates", status: 422
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
  end

  private

    def electorate_params
      params.require(:electorate).permit(:name, :fraction_id)
    end

    def find_or_initialize_electorate
      @electorate = params[:id] ? Electorate.find(params[:id]) : Electorate.new
    end
end
