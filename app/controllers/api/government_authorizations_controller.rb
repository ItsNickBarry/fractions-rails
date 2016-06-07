class Api::GovernmentAuthorizationsController < ApplicationController
  before_action :must_be_signed_in, only: [:create, :destroy]
  before_action :must_have_current_character, only: [:create, :destroy]
  before_action :find_authorizer, only: [:create]

  def create
    unless @authorizer.authorizes? current_character, :execute, :government_authorization_create
      render json: ["#{ @authorizer.name } does not authorize #{ current_character.name } to grant authorizations"], status: 403
      return
    end

    @government_authorization = @authorizer.government_authorizations_given.new(
      government_authorization_params
    )
    if @government_authorization.save
      render :show
    else
      render json: @government_authorization.errors.full_messages, status: 422
    end
  end

  def destroy
    @government_authorization = GovernmentAuthorization.find(params[:id])
    @authorizer = @government_authorization.authorizer
    if @authorizer.authorizes? current_character, :execute, :government_authorization_destroy
      @government_authorization.destroy
      render json: nil, status: 204
    else
      render json: ["#{ @authorizer.name } does not authorize #{ current_character.name } to revoke authorizations"], status: 403
    end
  end

  private

    def find_authorizer
      @authorizer = case
      when params[:fraction_id]
        Fraction.find(params[:fraction_id])
      when params[:electorate_id]
        Electorate.find(params[:electorate_id])
      when params[:position_id]
        Position.find(params[:position_id])
      when params[:region_id]
        Region.find(params[:region_id])
      end
    rescue
      render json: ["Not found"], status: 404
    end

    def government_authorization_params
      params.require(:government_authorization).permit(:authorizee_id, :authorizee_type, :authorization_type)
    end
end
