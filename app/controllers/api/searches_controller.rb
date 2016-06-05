class Api::SearchesController < ApplicationController
  def index
    @result = Electorate.joins(:fraction).limit(10).pluck('electorates.name', 'fractions.name') +
              Position.joins(:fraction).limit(10).pluck('positions.name', 'fractions.name')
    render :index
  end
end
