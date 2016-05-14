json.extract! @position, :id, :name

json.members @position.members do |member|
  json.extract! member, :id, :name
end

json.fraction do
  json.id @position.fraction.id
  json.name @position.fraction.name
end
