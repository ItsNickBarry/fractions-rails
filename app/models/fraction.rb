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
  validates :name, presence: true, uniqueness: true
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
  has_many :characters, through: :positions

  has_many :positions, dependent: :destroy
  has_many :electorates, dependent: :destroy
  has_many :regions, dependent: :destroy

  has_many :plots, through: :regions

  belongs_to :founder, polymorphic: true

  # TODO this should not be dependent: :destroy, but Fractions will be invalid without founder
  has_many :founded_fractions, as: :founder, class_name: 'Fraction'

  after_create :setup_defaults

  # TODO these authorizations are delegated to all of a Fraction's positions
  has_many :land_authorizations, as: :authorizee, dependent: :destroy
  has_many :government_authorizations, as: :authorizer, dependent: :destroy

  private

    def setup_defaults
      electorate = electorates.create(name: 'Electors of ' + self.name)
      position = positions.create(name: 'People of ' + self.name)
      region = regions.create(name: 'Lands of ' + self.name)

      ElectorateMembership.create electorate: electorate, position: position
      if self.founder.is_a? Character
        PositionMembership.create position: position, character: founder
      end

      authorize! position, :region_create
    end
end
