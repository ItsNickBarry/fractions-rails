# == Schema Information
#
# Table name: electorate_memberships
#
#  id            :integer          not null, primary key
#  electorate_id :integer          not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  member_type   :string
#  member_id     :integer
#

class ElectorateMembership < ActiveRecord::Base
  # TODO problem: weight of "absolute" memberships
  # TODO dependent destroy
  validates :position, :electorate, presence: true
  # TODO add message
  validates :position, uniqueness: { scope: :electorate,
    message: ""}

  belongs_to :position
  belongs_to :electorate

  has_one :fraction, through: :electorate
end
