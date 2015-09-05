if signed_in?
  json.current_user do
    json.extract! @current_user, :id, :username, :uuid, :current_character_id
  end

  if current_character
    json.current_character do
      json.extract! @current_character, :id, :name, :gender
    end
  end
end
