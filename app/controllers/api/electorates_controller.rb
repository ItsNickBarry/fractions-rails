class Api::ElectoratesController < ApplicationController
  before_action :must_be_signed_in, except: [:show, :index]
  before_action :find_or_initialize_electorate, except: [:create, :index]

  def create
    @electorate = Fraction.find(electorate_params[:fraction_id]).electorates.new(electorate_params);

    # TODO complex electorate initialization, including authorizations
    if @electorate.save
      render :show
    else
      render @electorate.errors.full_messages, status: 422
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
