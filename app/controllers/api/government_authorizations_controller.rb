class Api::GovernmentAuthorizationsController < ApplicationController
  before_action :must_be_signed_in, only: [:create, :destroy]
  before_action :must_have_current_character, only: [:create, :destroy]

  def index
    governable = case
    when params[:fraction_id]
      Fraction.find(params[:fraction_id])
    when params[:electorate_id]
      Electorate.find(params[:electorate_id])
    when params[:region_id]
      Region.find(params[:region_id])
    else
      render json: 'Invalid Governable object', status: 422
      return
    end

    @government_authorizations_given = governable.government_authorizations_given
    if governable.is_a?(Electorate) || governable.is_a?(Position)
      @government_authorizations_received = governable.government_authorizations_received
    end
  end

  def create

  end

  def destroy

  end

  private

    def government_authorization_params
      params.require(:government_authorization).permit(:authorizer_id, :authorizer_type, :authorizee_id, :authorizee_type, :authorization_type)
    end
end
