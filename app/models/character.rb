# == Schema Information
#
# Table name: characters
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  name       :string           not null
#  gender     :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Character < ActiveRecord::Base
  after_initialize :ensure_gender

  validates :name, presence: true, uniqueness: true
  validates :gender, presence: true
  # TODO validate that gender matches "FEMALE", "MALE", or "UNSPECIFIED"
  # TODO allow unspecified gender?

  belongs_to :user
  has_many :banishments
  has_many :banishing_fractions, through: :banishments, source: :fraction

  has_many :position_memberships
  has_many :positions, through: :position_memberships

  private

    def ensure_gender
      self.gender ||= "UNSPECIFIED"
    end
end
