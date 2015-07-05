json.id @user.id
json.username @user.username

json.characters @user.characters do |character|
  json.extract! character, :id, :name
end
