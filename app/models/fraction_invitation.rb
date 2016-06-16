class FractionInvitation < ActiveRecord::Base
  validates :character, :fraction, presence: true
  validates :character, uniqueness: { scope: :fraction,
    message: "" }
  validate :not_already_member, if: [:character, :fraction]

  belongs_to :character
  belongs_to :fraction

  # TODO destroy on accept
  private

    def not_already_member
      unless character.fractions.find_by(name: fraction.name).nil?
        errors.add(:character, 'must not be a member of fraction')
      end
    end
end
