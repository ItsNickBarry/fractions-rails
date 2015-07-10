json.id @character.id
json.name @character.name

json.fractions @character.fractions do |fraction|
  json.extract! fraction, :id, :name
end

json.user do
  json.id @character.user.id
  json.username @character.user.username
end
