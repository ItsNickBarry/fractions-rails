module Investable
  extend ActiveSupport::Concern

  included do
    has_many :members, through: :memberships, source: :member
    has_many :memberships, class_name: "#{ self.to_s }Membership", dependent: :destroy
  end

  def invest! member, parameters = {}
    # TODO parameters
    memberships.create parameters.merge(member: member)
  end

  def divest! member
    memberships.find_by(member: member).try(:destroy)
  end
end
