json.extract! @electorate, :id, :name

json.members @electorate.members do |member|
  json.extract! member, :id, :name
end

json.fraction do
  json.id @electorate.fraction.id
  json.name @electorate.fraction.name
end
