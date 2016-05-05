module Governable
  extend ActiveSupport::Concern

  included do
    has_many :government_authorizations, as: :authorizer, dependent: :destroy

    has_many :government_authorized_positions, through: :government_authorizations, source: :authorizee, source_type: 'Position'
    has_many :government_authorized_electorates, through: :government_authorizations, source: :authorizee, source_type: 'Electorate'

    # collections of characters who can execute, call for a vote, or vote
    has_many :government_executable_characters, through: :government_authorized_positions, source: :members
    # has_many :government_callable_characters, through: :government_authorized_electorates, source: :callers
    # has_many :government_votable_characters, through: :government_authorized_electorates, source: :voters
  end

  def authorize! (authorizee, authorization_type)
    GovernmentAuthorization.create(
      authorizer: self,
      authorizee: authorizee,
      authorization_type: authorization_type
    )
  end

  def authorizations_for (character, authorization_level, authorization_type = nil)
    authorizee_type = {
      execute: 'Position',
      call: 'Electorate',
      vote: 'Electorate'
    }[authorization_level] || (raise "Invalid authorization level")

    replacements = {
      authorization_type:         authorization_type,

      authorizee_id:          "#{ authorizee_type.downcase }_id",
      authorizee_type:            authorizee_type,
      authorizee_memberships: "#{ authorizee_type.downcase }_memberships",

      authorizer_id:              self.id,
      authorizer_type:            self.class.to_s,

      character_id:               character.id,
    }

    GovernmentAuthorization.find_by_sql([<<-SQL, replacements])
      SELECT  government_authorizations.*
        FROM  government_authorizations
        JOIN  :authorizee_memberships
          ON  government_authorizations.authorizee_id      = :authorizee_memberships.:authorizee_id
          AND government_authorizations.authorizee_type    = :authorizee_type
          AND government_authorizations.authorizer_id      = :authorizer_id
          AND government_authorizations.authorizer_type    = :authorizer_type
          AND position_memberships.character_id            = :character_id
    #{   'AND electorate_memberships.caller                = "t"'                   if authorization_level == :call } -- TODO ensure boolean comparison
    #{   'AND electorate_memberships.weight                > 0'                     if authorization_level == :vote } -- TODO depends on how vote weights work
    #{   'AND government_authorizations.authorization_type = :authorization_type'   if authorization_type           }
    #{ 'JOIN  positions ON electorate_memberships.position_id          = positions.id' if authorizee_type[0] == 'E' }
    #{ 'JOIN  position_memberships ON position_memberships.position_id = positions.id' if authorizee_type[0] == 'E' }
    SQL
  end

  def authorizes? (character, authorization_level, authorization_type = nil)
    authorizations_for(character, authorization_level, authorization_type).any?
  end

  module ClassMethods
    def government_authorization_types
      # TODO these should correspond to method names, so they can be easily
      # referenced by Ballots; can then check for existence of method, rather
      # than this list?
      {
        Electorate => [
          :divest,
          :invest
        ],

        Fraction => [
          # :root # TODO use explicit 'root' authorization?

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
          :character_unbanish,
          :character_invite,
          :character_uninvite,

          :war_declare,
          :war_join,
          :war_surrender,
        ],

        Position => [
          :divest,
          :invest
        ],

        Region => [

        ]
      }[self] + [ :authorize, :deauthorize ]
    end
  end
end
