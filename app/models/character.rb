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
  after_create :ensure_user_has_current_character
  # TODO probably need to collate nocase for case-insensitive name validation
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :gender, presence: true
  validate :gender_is_valid

  belongs_to :user
  has_many :banishments, dependent: :destroy
  has_many :banishing_fractions, through: :banishments, source: :fraction

  has_many :position_memberships, dependent: :destroy
  has_many :positions, through: :position_memberships

  has_many :fractions, through: :position_memberships, source: :fraction

  has_many :fraction_invitations, dependent: :destroy

  # TODO this should not be dependent: :destroy, but Fractions will be invalid without founder
  has_many :founded_fractions, as: :founder, class_name: 'Fraction'

  # has_many :government_authorizations ... TODO get this from positions/ electorates
  # has_many :land_authorizations ... TODO get this from positions/ fractions

  def can_found_fraction?
    # TODO character found fraction conditions
    last_founded_fraction = founded_fractions.order(:created_at).first
    !last_founded_fraction || last_founded_fraction.created_at < 7.days.ago
  end

  def fraction_join! fraction
    if invitation = fraction_invitations.find_by(fraction: fraction)
      fraction.default_position.invest! self
      invitation.destroy
    end
  end

  private

    def ensure_user_has_current_character
      unless user.current_character
        user.update(current_character: self)
      end
    end

    def gender_is_valid
      unless ['F', 'M'].include? self.gender
        errors.add(:gender, 'must be "F" or "M"')
      end
    end
end
