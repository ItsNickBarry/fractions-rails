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
  validates :name, presence: true, uniqueness: true
  validates :gender, presence: true
  validate :gender_is_valid

  belongs_to :user
  has_many :banishments, dependent: :destroy
  has_many :banishing_fractions, through: :banishments, source: :fraction

  has_many :position_memberships, dependent: :destroy
  has_many :positions, through: :position_memberships

  has_many :fractions, through: :position_memberships, source: :fraction

  # TODO this should not be dependent: :destroy, but Fractions will be invalid without founder
  has_many :founded_fractions, as: :founder, class_name: 'Fraction'

  # has_many :government_authorizations ... TODO get this from positions/ electorates
  # has_many :land_authorizations ... TODO get this from positions/ fractions

  def can_found_fraction?
    # TODO character found fraction conditions
    last_founded_fraction = founded_fractions.order(:created_at).first
    !last_founded_fraction || last_founded_fraction.created_at < 7.days.ago
  end

  private

    def gender_is_valid
      unless ['F', 'M'].include? self.gender
        errors.add(:gender, 'must be "F" or "M"')
      end
    end
end
