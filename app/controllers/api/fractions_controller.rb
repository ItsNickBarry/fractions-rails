class Api::FractionsController < ApplicationController
  before_action :must_be_signed_in, except: [:show, :index]
  before_action :find_or_initialize_fraction, except: [:create, :index]

  def create
    @founder = params[:founder_type].constantize.find(params[:founder_id])
    # TODO make sure current_user.active_characer is allowed to do this
    @fraction = @founder.founded_fractions.new(fraction_params);
    # TODO complex fraction initialization
    # needs authorizations
    if @fraction.save
      # TODO is @fraction okay, or should it render the whole :show jbuilder?
      render :show
    else
      render @fraction.errors.full_messages, status: 422
    end
  end

  def show
  end

  private

    def fraction_params
      params.require(:fraction).permit(:name)
    end

    def find_or_initialize_fraction
      @fraction = params[:id] ? Fraction.find(params[:id]) : Fraction.new
    end
end
