class Api::GovernmentAuthorizationsController < ApplicationController
  before_action :must_be_signed_in

  def create

  end

  def destroy

  end

  private

    def government_authorization_params
      params.require(:government_authorization).permit(:authorizer_id, :authorizer_type, :authorizee_id, :authorizee_type, :authorization_type)
    end
end
