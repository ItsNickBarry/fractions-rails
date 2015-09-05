Fractions.Concerns.Governable = {
  currentCharacterGovernmentAuthorizations: function (authorization_type, authorization_level) {
    return this.get('current_character_government_authorizations')
           && _.contains(this.get('current_character_government_authorizations')[authorization_level], authorization_type);
  },

  executable: function (authorization_type) {
    return this.currentCharacterGovernmentAuthorizations(authorization_type, 'executable')
  },

  callable: function (authorization_type) {
    return this.currentCharacterGovernmentAuthorizations(authorization_type, 'callable')
  },

  votable: function (authorization_type) {
    return this.currentCharacterGovernmentAuthorizations(authorization_type, 'votable')
  },
};
