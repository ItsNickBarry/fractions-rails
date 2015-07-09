json.id @fraction.id
json.name @fraction.name

json.electorates @fraction.electorates do |electorate|
  json.extract! electorate, :id, :name
end

json.positions @fraction.positions do |position|
  json.extract! position, :id, :name
end

json.regions @fraction.regions do |region|
  json.extract! region, :id, :name
end
