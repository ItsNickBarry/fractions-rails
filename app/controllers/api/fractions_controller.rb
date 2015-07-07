class Api::FractionsController < ApplicationController
  before_action :must_be_signed_in, except: [:show, :index]
  before_action :find_or_initialize_fraction, except: [:create, :index]

  # def create
  #   @fraction = current_user.fractions.new(fraction_params);
  #   debugger
  #   # TODO complex fraction initialization
  #   # needs position, electorate, authorizations
  #   if @fraction.save
  #     render @fraction
  #   else
  #     render @fraction.errors.full_messages, status: 422
  #   end
  # end

  def show
  end

  private

    def fraction_params
      params.require(:fraction).permit(:name, :gender)
    end

    def find_or_initialize_fraction
      @fraction = params[:id] ? Fraction.find(params[:id]) : Fraction.new
    end
end
