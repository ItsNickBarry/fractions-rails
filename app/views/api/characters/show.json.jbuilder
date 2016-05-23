json.extract! @character, :id, :name, :gender

json.user do
  json.extract! @character.user, :id, :username
end

json.fractions @character.fractions do |fraction|
  json.extract! fraction, :id, :name
end

json.founded_fractions @character.founded_fractions do |fraction|
  json.extract! fraction, :id, :name
end
