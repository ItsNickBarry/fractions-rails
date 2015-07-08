json.id @character.id
json.name @character.name

json.user do
  json.id @character.user.id
  json.username @character.user.username
end
