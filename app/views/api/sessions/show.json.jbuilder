if signed_in?
  json.current_user do
    json.extract! @current_user, :id, :username
  end

  if current_character
    json.current_character do
      json.extract! @current_character, :id, :name
    end
  end
end
