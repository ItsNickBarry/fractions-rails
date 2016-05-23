class Api::FractionsController < ApplicationController
  before_action :must_be_signed_in, only: [:create]
  before_action :must_have_current_character, only: [:create]

  def index
    @fractions = Fraction.roots
  end

  def create
    @founder = founder_params[:id] ? Fraction.find_by(founder_params) : current_character
    @fraction = @founder.founded_fractions.new(fraction_params)

    if @founder.is_a? Fraction
      unless @founder.authorizes? current_character, :execute, :fraction_create
        render json: "#{ @founder.name } does not authorize #{ current_character.name } to create child fractions on its behalf", status: 403
        return
      end
      @fraction.assign_attributes parent: @founder
    elsif @founder.is_a? Character
      unless @founder.can_found_fraction?
        render json: "#{ @founder.name } cannot found a fraction", status: 403
        return
      end
    end

    if @fraction.save
      render :show
    else
      render json: @fraction.errors.full_messages, status: 422
    end
  end

  def show
    @fraction = Fraction.find(params[:id])
  end

  private

    def fraction_params
      params.require(:fraction).permit(:name)
    end

    def founder_params
      params.require(:founder).permit(:id)
    end
end
