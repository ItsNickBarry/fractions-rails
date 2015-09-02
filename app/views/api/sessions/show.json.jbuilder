json.extract! @current_user, :id, :username, :uuid, :current_character_id

# json.current_character do
#   json.extract! @current_character, :name, :gender
#
#   json.government_authorizations @current_character.government_authorizations do |government_authorization|
#     json.extract! government_authorization, :authorizer_id, :authorizer_type, :authorizee_id, :authorizee_type, :authorization_type
#   end
# end if @current_character
