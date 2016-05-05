require 'test_helper'

class FractionConnectionRequestTest < ActiveSupport::TestCase
  def setup
    # https://en.wikipedia.org/wiki/Kalmar_Union
    # 1397
    @fraction_connection_request = FractionConnectionRequest.new(
      requester: fractions(:danmark),
      requestee: fractions(:sverige),
      offer: 'parent'
    )
  end

  test "should be valid" do
    assert @fraction_connection_request.valid?
  end

  test "should have requester" do
    @fraction_connection_request.requester = nil
    refute @fraction_connection_request.valid?
  end

  test "should have requestee" do
    @fraction_connection_request.requestee = nil
    refute @fraction_connection_request.valid?
  end

  test "should have offer of 'child' or 'parent'" do
    @fraction_connection_request.offer = ''
    refute @fraction_connection_request.valid?
    @fraction_connection_request.offer = 'peace and respect'
    refute @fraction_connection_request.valid?
  end

  test "requestee should be unique in scope of requester" do
    @fraction_connection_request.save!
    duplicate_fraction_connection_request = FractionConnectionRequest.new(
      requester: @fraction_connection_request.requester,
      requestee: @fraction_connection_request.requestee,
      offer: 'child'
    )
    refute duplicate_fraction_connection_request.valid?
  end

  test "complimentary request should not be valid" do
    offer = @fraction_connection_request.offer == 'parent' ? 'child' : 'parent'
    @fraction_connection_request.save!
    complimentary_request = FractionConnectionRequest.new(
      requester: @fraction_connection_request.requestee,
      requestee: @fraction_connection_request.requester,
      offer: offer
    )
    refute complimentary_request.valid?
  end

  test "request to connect already-connected fraction should not be valid" do
    @fraction_connection_request.requestee = fractions(:sjælland)
    refute @fraction_connection_request.valid?
  end

  test "request to connect to descendant fraction as child should not be valid" do
    @fraction_connection_request.requestee = fractions(:copenhagen)
    @fraction_connection_request.offer = 'child'
    refute @fraction_connection_request.valid?
  end

  test "request to connect to ancestor fraction as parent should not be valid" do
    @fraction_connection_request.requester = fractions(:stockholm)
    refute @fraction_connection_request.valid?
  end
end
