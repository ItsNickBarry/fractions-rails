json.extract! fraction, :id, :name
json.children fraction.children do |child|
  # recursively render partial for each child
  json.partial! 'api/fractions/fraction_with_children', fraction: child
end
