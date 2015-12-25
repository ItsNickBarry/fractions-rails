class Api::UserPlotsController < ApplicationController

  def show
    @user_plot = UserPlot.new(user_plot_params)
    render :show
  end

  private

    def user_plot_params
      params.permit(:uuid, :world_id, :x, :z)
    end
end
