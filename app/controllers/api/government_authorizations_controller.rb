class Api::GovernmentAuthorizationsController < ApplicationController
  before_action :must_be_signed_in
  before_action :find_or_initialize_government_authorization, except: [:create, :index]

  def create

  end

  def destroy

  end

  private

    def government_authorization_params
      params.require(:government_authorization).permit(:authorizer_id, :authorizer_type, :authorizee_id, :authorizee_type, :authorization_type)
    end
end
