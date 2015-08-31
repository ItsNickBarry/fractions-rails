json.id @fraction.id
json.name @fraction.name

json.parent do
  json.extract! @fraction.parent, :id, :name
end if @fraction.parent
json.founder do
  json.type @fraction.founder_type
  json.extract! @fraction.founder, :id, :name
end
json.founded_at @fraction.created_at

json.children @fraction.children do |child|
  json.extract! child, :id, :name
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
