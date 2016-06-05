class Api::SearchesController < ApplicationController
  def index
    # TODO cache
    suggestions = []
    (params['classes'] || []).each do |class_name|
      # TODO ask someone if this is a terrible idea
      query = (params['query'] || '').split('').join('%')
      results = class_name.constantize.where("name LIKE '%#{ query }%'")
      suggestions += results.map do |result|
        {
          value: result.name,
          data: {
            id: result.id,
            category: class_name.pluralize,
          }
        }
      end
    end
    render json: { suggestions: suggestions }
  end
end
