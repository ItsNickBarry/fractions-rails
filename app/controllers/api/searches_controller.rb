class Api::SearchesController < ApplicationController
  def index
    # TODO cache
    suggestions = []
    (params['classes'] || []).each do |class_name|
      # TODO ask someone if this is a terrible idea
      # TODO enable inclusion of name of relation in query:
      #      example: 'pristina people' -> 'People of Pristina'
      # TODO let Jquery.Autocomplete highlight query in results which include class name
      query = (params['query'] || '').split('').join('%')
      results = class_name.constantize.where("'#{ class_name }' || name LIKE '%#{ query }%'").limit(12)
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
