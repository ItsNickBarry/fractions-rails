class Position < ActiveRecord::Base
  # TODO dependent destroy
  validates :fraction, :name, presence: true
  # TODO does order of scope have to match migration?
  # TODO can scope be :fraction instead of :fraction_id?
  validates :name, uniqueness: { scope: :fraction,
    message: ""}

  belongs_to :fraction

  has_many :position_memberships
  has_many :characters, through: :position_memberships
end