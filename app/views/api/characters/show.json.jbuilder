json.extract! @character, :id, :name, :gender

json.founded_fractions @character.founded_fractions do |fraction|
  json.extract! fraction, :id, :name
end

json.fractions @character.fractions do |fraction|
  json.extract! fraction, :id, :name
end

json.user do
  json.id @character.user.id
  json.username @character.user.username
end
