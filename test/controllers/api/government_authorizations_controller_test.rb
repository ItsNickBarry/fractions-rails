require 'test_helper'

class Api::GovernmentAuthorizationsControllerTest < ActionController::TestCase
  test "index" do
    fraction = fractions(:danmark)
    get :index, fraction_id: fraction.id, format: :json
    assert_response 200

    parse response

    assert_equal fraction.government_authorizations_given.count,
                 @json['governmentAuthorizationsGiven'].length
  end

  test "index should find any governable authorizer type" do
    [
      Fraction,
      Electorate,
      Position,
      Region
    ].each do |type|
      get :index, "#{ type.to_s.downcase }_id" => type.first.id, format: :json
      assert assigns(:authorizer).is_a? type
      assert_response 200
    end
  end

  test "create" do
    act_as characters(:barack_obama)
    authorizer = fractions(:united_states)
    authorizee = positions(:united_states_department_of_homeland_security)

    assert_difference 'authorizer.government_authorizations_given.count', 1 do
      post :create, fraction_id: authorizer.id, government_authorization: {
        authorizee_id: authorizee.id,
        authorizee_type: authorizee.class.to_s,
        authorization_type: 'character_banish'
      }, format: :json
      assert_response 200
    end
  end

  test "create with invalid parameters" do
    act_as characters(:barack_obama)
    authorizer = fractions(:united_states)
    authorizee = positions(:united_states_department_of_homeland_security)

    assert_no_difference 'authorizer.government_authorizations_given.count' do
      post :create, fraction_id: authorizer.id, government_authorization: {
        authorizee_id: authorizee.id,
        authorizee_type: authorizee.class.to_s,
        authorization_type: 'invalid_authorization_type'
      }, format: :json
      assert_response 422
    end
  end

  test "create without authorization" do
    act_as characters(:taavi_rõivas)
    authorizer = fractions(:united_states)
    authorizee = positions(:united_states_department_of_homeland_security)

    assert_no_difference 'authorizer.government_authorizations_given.count' do
      post :create, fraction_id: authorizer.id, government_authorization: {
        authorizee_id: authorizee.id,
        authorizee_type: authorizee.class.to_s,
        authorization_type: 'invalid_authorization_type'
      }, format: :json
      assert_response 403
    end
  end

  test "destroy" do
    act_as characters(:barack_obama)
    government_authorization = government_authorizations(:fraction_united_states_position_united_states_president_fraction_create)
    authorizer = government_authorization.authorizer

    assert_difference 'authorizer.government_authorizations_given.count', -1 do
      delete :destroy, id: government_authorization.id, format: :json
      assert_response 204
    end
  end

  test "destroy without authorization" do
    act_as characters(:taavi_rõivas)
    government_authorization = government_authorizations(:fraction_united_states_position_united_states_president_fraction_create)
    authorizer = government_authorization.authorizer

    assert_no_difference 'authorizer.government_authorizations_given.count' do
      delete :destroy, id: government_authorization.id, format: :json
      assert_response 403
    end
  end
end
