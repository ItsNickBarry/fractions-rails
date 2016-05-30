# == Schema Information
#
# Table name: electorate_memberships
#
#  id            :integer          not null, primary key
#  electorate_id :integer          not null
#  position_id   :integer          not null
#  caller        :boolean          default(FALSE), not null
#  electoral     :boolean          default(FALSE), not null
#  absolute      :boolean          default(FALSE), not null
#  weight        :float            default(1.0), not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class ElectorateMembership < ActiveRecord::Base
  # TODO problem: weight of "absolute" memberships
  # TODO dependent destroy
  validates :member, :electorate, presence: true
  # TODO add message
  validates :member, uniqueness: { scope: :electorate,
    message: ""}

  belongs_to :member, class_name: 'Position', foreign_key: :position_id
  belongs_to :electorate

  has_one :fraction, through: :electorate
end
