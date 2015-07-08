class Api::RegionsController < ApplicationController
  before_action :must_be_signed_in, except: [:show, :index]
  before_action :find_or_initialize_region, except: [:create, :index]

  def create
    @region = Fraction.find(region_params[:fraction_id]).regions.new(region_params);

    # TODO complex region initialization
    # needs authorizations
    if @region.save
      render :show
    else
      render @region.errors.full_messages, status: 422
    end
  end

  def show
  end

  private

    def region_params
      params.require(:region).permit(:name, :fraction_id)
    end

    def find_or_initialize_region
      @region = params[:id] ? Region.find(params[:id]) : Region.new
    end
end
