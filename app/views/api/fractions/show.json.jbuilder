json.extract! @fraction, :id, :name, :description, :created_at

unless @fraction.root?
  json.root do
    json.extract! @fraction.root, :id, :name
  end
end

if @fraction.parent
  json.parent do
    json.extract! @fraction.parent, :id, :name
  end
end

json.founder do
  json.extract! @fraction.founder, :id, :name
  json.type @fraction.founder_type
end

json.founded_fractions @fraction.founded_fractions do |fraction|
  json.extract! fraction, :id, :name
end

json.children @fraction.children do |fraction|
  json.extract! fraction, :id, :name
end

json.electorates @fraction.electorates do |electorate|
  json.extract! electorate, :id, :name
end

json.positions @fraction.positions do |position|
  json.extract! position, :id, :name
end

json.regions @fraction.regions do |region|
  json.extract! region, :id, :name
end

json.partial! 'api/government_authorizations/government_authorizations_given', authorizer: @fraction

json.partial! 'api/government_authorizations/current_character_government_authorizations', authorizer: @fraction
