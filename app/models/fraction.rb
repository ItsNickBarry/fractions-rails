# == Schema Information
#
# Table name: fractions
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  ancestry   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Fraction < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true

  has_ancestry
  has_many :banishments
  has_many :banished_characters, through: :banishments, source: :character
end
