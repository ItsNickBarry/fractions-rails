# == Schema Information
#
# Table name: fractions
#
#  id           :integer          not null, primary key
#  name         :string           not null
#  ancestry     :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  founder_id   :integer
#  founder_type :string
#

class Fraction < ActiveRecord::Base
  include Governable
  validates :name, presence: true, uniqueness: true
  validates :founder, presence: true

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
  has_many :banishments
  has_many :banished_characters, through: :banishments, source: :character
  has_many :characters, through: :positions
  has_many :positions
  has_many :electorates
  has_many :regions
  has_many :plots, through: :regions

  belongs_to :founder, polymorphic: true
  has_many :founded_fractions, as: :founder, class_name: 'Fraction'

  after_create :setup_default_objects

  # TODO these authorizations are delegated to all of a Fraction's positions
  has_many :land_authorizations, as: :authorizee

  def self.authorization_types
    [
      # inter-fraction relationships
      :child_connect,
      :child_create,
      :child_disconnect,

      :parent_connect,
      :parent_disconnect,

      # component objects
      :electorate_create,
      :electorate_destroy,

      :position_create,
      :position_destroy,

      :region_create,
      :region_destroy,


      :character_banish,
      :character_invite,
      :character_unbanish,

      :war_declare,
      :war_join,
      :war_surrender,

      # self
      # :self_...

      :root # TODO use explicit 'root' authorization?
    ]
  end

  private

    def setup_default_objects
      electorates.create(name: "DEFAULT")
      positions.create(name: "DEFAULT")
      regions.create(name: "DEFAULT")
      assign_authorizations
    end

    def assign_authorizations
      # TODO
    end
end
