# == Schema Information
#
# Table name: government_authorizations
#
#  id                 :integer          not null, primary key
#  authorizer_id      :integer          not null
#  authorizer_type    :string           not null
#  authorizee_id      :integer          not null
#  authorizee_type    :string           not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  authorization_type :string           not null
#

require 'test_helper'

class GovernmentAuthorizationTest < ActiveSupport::TestCase
  def setup
    @authorizer = fractions(:united_states)
    @authorizee = positions(:united_states_president)
    @government_authorization = GovernmentAuthorization.new(
      authorizer: @authorizer,
      authorizee: @authorizee,
      authorization_type: 'war_declare'
    )
  end

  def copy government_authorization
    GovernmentAuthorization.new(
      authorizer: government_authorization.authorizer,
      authorizee: government_authorization.authorizee,
      authorization_type: government_authorization.authorization_type
    )
  end

  test "should be valid" do
    assert @government_authorization.valid?
  end

  test "should have authorizer" do
    @government_authorization.authorizer = nil
    refute @government_authorization.valid?
  end

  test "should have authorizee" do
    @government_authorization.authorizee = nil
    refute @government_authorization.valid?
  end

  test "should have valid authorization type for authorizer" do
    @government_authorization.authorization_type = nil
    refute @government_authorization.valid?
    @government_authorization.authorization_type = 'invalid_authorization_type'
    refute @government_authorization.valid?
  end

  test "authorization type should be unique in scope of authorizer and authorizee" do
    @government_authorization.save!
    duplicate = copy @government_authorization
    refute duplicate.valid?

    duplicate.authorizer = fractions(:eesti)
    assert duplicate.valid?
    
    duplicate = copy @government_authorization
    duplicate.authorizee = positions(:united_kingdom_monarch)
    assert duplicate.valid?

    duplicate = copy @government_authorization
    duplicate.authorization_type = 'electorate_create'
    assert duplicate.valid?
  end
end
