json.suggestions do
  json.array! @result.map { |el| { value: el[0], data: { category: el[1] } } }
end
