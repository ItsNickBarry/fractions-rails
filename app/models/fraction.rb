# == Schema Information
#
# Table name: fractions
#
#  id           :integer          not null, primary key
#  name         :string           not null
#  ancestry     :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  founder_id   :integer          not null
#  founder_type :string           not null
#

class Fraction < ActiveRecord::Base
  include Governable
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :founder, presence: true

  # TODO add orphan_strategy and cache_depth
  has_ancestry
  # parent           Returns the parent of the record, nil for a root node
  # parent_id        Returns the id of the parent of the record, nil for a root node
  # root             Returns the root of the tree the record is in, self for a root node
  # root_id          Returns the id of the root of the tree the record is in
  # root?, is_root?  Returns true if the record is a root node, false otherwise
  # ancestor_ids     Returns a list of ancestor ids, starting with the root id and ending with the parent id
  # ancestors        Scopes the model on ancestors of the record
  # path_ids         Returns a list the path ids, starting with the root id and ending with the node's own id
  # path             Scopes model on path records of the record
  # children         Scopes the model on children of the record
  # child_ids        Returns a list of child ids
  # has_children?    Returns true if the record has any children, false otherwise
  # is_childless?    Returns true is the record has no children, false otherwise
  # siblings         Scopes the model on siblings of the record, the record itself is included*
  # sibling_ids      Returns a list of sibling ids
  # has_siblings?    Returns true if the record's parent has more than one child
  # is_only_child?   Returns true if the record is the only child of its parent
  # descendants      Scopes the model on direct and indirect children of the record
  # descendant_ids   Returns a list of a descendant ids
  # subtree          Scopes the model on descendants and itself
  # subtree_ids      Returns a list of all ids in the record's subtree
  # depth            Return the depth of the node, root nodes are at depth 0
  has_many :banishments, dependent: :destroy
  has_many :banished_characters, through: :banishments, source: :character
  has_many :characters, through: :positions, source: :members

  has_many :positions, dependent: :destroy
  has_many :electorates, dependent: :destroy
  has_many :regions, dependent: :destroy

  def default_electorate
    electorates.first
  end

  def default_position
    positions.first
  end

  def default_region
    regions.first
  end

  has_many :plots, through: :regions

  belongs_to :founder, polymorphic: true

  has_many :fraction_invitations, dependent: :destroy
  # TODO this should not be dependent: :destroy, but Fractions will be invalid without founder
  has_many :founded_fractions, as: :founder, class_name: 'Fraction'

  after_create :setup_defaults

  # TODO authorizations are delegated to all of a Fraction's positions
  has_many :land_authorizations, as: :authorizee, dependent: :destroy

  def fraction_create! attributes
    founded_fractions.create(attributes)
  end

  def child_connect! fraction
    request = FractionConnectionRequest.find_by(requester: fraction, offer: 'child')
    if request
      request.destroy
      fraction.update(parent: self)
    else
      FractionConnectionRequest.create(requester: self, requestee: fraction, offer: 'parent')
    end
  end

  def child_disconnect! fraction
    fraction.update(parent: nil)
  end

  def parent_connect! fraction
    request = FractionConnectionRequest.find_by(requester: fraction, offer: 'parent')
    if request && self.parent.nil?
      # TODO report error if child already has parent
      request.destroy
      update(parent: fraction)
    else
      FractionConnectionRequest.create(requester: self, requestee: fraction, offer: 'child')
    end
  end

  def parent_disconnect!
    update(parent: nil)
  end

  def electorate_create! attributes
    electorates.create(attributes)
  end

  def electorate_destroy! electorate
    electorate.destroy
  end

  def position_create! attributes
    positions.create(attributes)
  end

  def position_destroy! position
    position.destroy
  end

  def region_create! attributes
    regions.create(attributes)
  end

  def region_destroy! region
    region.destroy
  end

  def character_banish! character
    banishments.create(character: character)
  end

  def character_unbanish! character
    banishments.find_by(character: character).try(:destroy)
  end

  def character_invite! character
    fraction_invitations.create(character: character)
  end

  def character_uninvite! character
    fraction_invitations.find_by(character: character).try(:destroy)
  end

  # def war_declare!
  #
  # end
  #
  # def war_join! war
  #
  # end
  #
  # def war_surrender! war
  #
  # end

  private

    def setup_defaults
      electorate = electorate_create!(name: "Electors of #{ self.name }")
      position = position_create!(name: "People of #{ self.name }")
      region = region_create!(name: "Lands of #{ self.name }")

      ElectorateMembership.create electorate: electorate, position: position
      if self.founder.is_a? Character
        PositionMembership.create position: position, character: founder
      end

      authorize! position, :region_create
    end
end
