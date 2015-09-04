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

  def authorizes? (character, authorization_level, authorization_type = nil)
    raise "Invalid authorization level" unless [:execute, :call, :vote].include? authorization_level
    authorizee_type = authorization_level == :execute ? 'position' : 'electorate'

    GovernmentAuthorization.find_by_sql([<<-SQL, self.id, character.id])
      SELECT government_authorizations.*
        FROM #{authorizee_type}_memberships
        JOIN #{authorizee_type}s
        ON #{authorizee_type}s.id = #{authorizee_type}_memberships.#{authorizee_type}_id
        JOIN government_authorizations
        ON government_authorizations.authorizee_type = "#{authorizee_type.capitalize}"
          AND government_authorizations.authorizee_id = #{authorizee_type}s.id
        WHERE government_authorizations.authorizer_type = "#{self.class}"
          AND government_authorizations.authorizer_id = ?
          AND #{authorizee_type}_memberships.character_id = ?
          -- AND electorate_memberships.TODO whether or not electorate_membership includes vote-calling power
    SQL
  end

  private

    def test
      debugger
    end
end
