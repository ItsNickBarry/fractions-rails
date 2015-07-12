json.id @position.id
json.name @position.name

json.characters @position.characters do |character|
  json.extract! character, :id, :name
end

json.fraction do
  json.id @position.fraction.id
  json.name @position.fraction.name
end
