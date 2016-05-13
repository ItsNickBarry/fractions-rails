json.extract! @user, :id, :username, :uuid

# json.current_user true if @user.id == current_user.id

# json.active_character_id @user.active_character.id

json.characters @user.characters do |character|
  json.extract! character, :id, :name
end
