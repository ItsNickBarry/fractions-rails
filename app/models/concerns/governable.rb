module Governable
  extend ActiveSupport::Concern

  included do
    has_many :government_authorizations, as: :authorizer

    has_many :government_authorized_positions, through: :government_authorizations, source: :authorizee, source_type: 'Position'
    has_many :government_authorized_electorates, through: :government_authorizations, source: :authorizee, source_type: 'Electorate'

    # collections of characters who can execute, call for a vote, or vote
    has_many :government_executable_characters, through: :government_authorized_positions, source: :characters
    # has_many :government_callable_characters, through: :government_authorized_electorates, source: :callers
    # has_many :government_votable_characters, through: :government_authorized_electorates, source: :voters
  end

  def authorizes (character, authorization_level, authorization_type = nil)
    authorizee_class = {
      execute: Position,
      call: Electorate,
      vote: Electorate
    }[authorization_level] || (raise "Invalid authorization level")

    replacements = {
      authorizer_id: self.id,
      authorizer_type: self.class.to_s,
      authorizee_type: authorizee_class.to_s,
      authorization_type: authorization_type,
      character_id: character.id,
      authorizee_table: authorizee_class.table_name,
      authorizee_memberships_table: authorizee_class.to_s.downcase + '_memberships',
      authorizee_reference_column: authorizee_class.to_s.downcase + '_id'
    }

    # select and parse all government authorizations the character has
    # TODO retain authorizee_id and authorizee_type, to identify through which authorizees the character is authorized
    # TODO maybe this should just return the position/electorate?  is the government authorization itself really useful?
    GovernmentAuthorization.find_by_sql([<<-SQL, replacements])
      SELECT government_authorizations.*
      FROM government_authorizations
      JOIN :authorizee_memberships_table
        ON :authorizee_memberships_table.:authorizee_reference_column = government_authorizations.authorizee_id
          AND government_authorizations.authorizee_type = :authorizee_type
      WHERE government_authorizations.authorizer_type = :authorizer_type
        AND government_authorizations.authorizer_id = :authorizer_id
        AND :authorizee_memberships_table.character_id = :character_id
        #{'AND government_authorizations.authorization_type LIKE :authorization_type' if authorization_type}
    SQL
  end

  def authorizes? (character, authorization_level, authorization_type = nil)
    authorizes(character, authorization_level, authorization_type).any?
  end

  module ClassMethods
    def government_authorization_types
      {
        Electorate => [

        ],

        Fraction => [
          # inter-fraction relationships
          :child_connect,
          :child_disconnect,

          :fraction_create,

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
          :self_manage,

          :root # TODO use explicit 'root' authorization?
        ],

        Position => [

        ],

        Region => [

        ]
      }[self]
    end
  end
end
