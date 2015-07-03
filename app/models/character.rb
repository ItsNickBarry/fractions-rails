class Character < ActiveRecord::Base
  after_initialize :ensure_gender

  validates :name, presence: true, uniqueness: true
  validates :gender, presence: true
  # TODO validate that gender matches "FEMALE", "MALE", or "UNSPECIFIED"
  # TODO allow unspecified gender?

  belongs_to :user

  private

    def ensure_gender
      self.gender ||= "UNSPECIFIED"
    end
end
