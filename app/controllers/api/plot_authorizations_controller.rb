class Api::PlotAuthorizationsController < ApplicationController
  def show
    # TODO rewrite all PlotAuthorization logic in the Java plugin
    @plot_authorization = PlotAuthorization.new(plot_authorization_params)
    render :show
  end

  private

    def plot_authorization_params
      params.permit(:uuid, :world_id, :x, :z)
    end
end
