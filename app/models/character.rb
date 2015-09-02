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

  validates :user, presence: true
  validates :name, presence: true, uniqueness: true
  validates :gender, presence: true
  validate :gender_is_valid

  belongs_to :user
  has_many :banishments
  has_many :banishing_fractions, through: :banishments, source: :fraction

  has_many :position_memberships
  has_many :positions, through: :position_memberships

  has_many :fractions, through: :position_memberships, source: :fraction

  has_many :founded_fractions, as: :founder, class_name: 'Fraction'

  # has_many :government_authorizations ... TODO get this from positions/ electorates
  # has_many :land_authorizations ... TODO get this from positions/ fractions

  private

    def ensure_gender
      self.gender ||= "UNSPECIFIED"
    end

    def gender_is_valid
      # TODO allow unspecified gender?
      unless ['FEMALE', 'MALE', 'UNSPECIFIED'].include? self.gender
        errors.add(:gender, "must be \"FEMALE\", \"MALE\", or \"UNSPECIFIED\"")
      end
    end
end
