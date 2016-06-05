Fractions.Concerns.Governable = {
  governable: true,

  governmentAuthorizationTypes: function () {
    // TODO fetch authorizations from server 
    return {
      'Fraction': [
        'child_connect',
        'child_disconnect',

        'fraction_create',

        'parent_connect',
        'parent_disconnect',

        'electorate_create',
        'electorate_destroy',

        'position_create',
        'position_destroy',

        'region_create',
        'region_destroy',


        'character_banish',
        'character_unbanish',
        'character_invite',
        'character_uninvite',

        'war_declare',
        'war_join',
        'war_surrender',
      ]
    }[this.class].concat([
      'government_authorization_create',
      'government_authorization_destroy',
    ]);
  },

  executable: function (authorization_type) {
    return this._authorizes('executable', authorization_type);
  },

  callable: function (authorization_type) {
    return this._authorizes('callable', authorization_type);
  },

  votable: function (authorization_type) {
    return this._authorizes('votable', authorization_type);
  },

  _authorizes: function (authorization_level, authorization_type) {
    var authorizationSet = this.get('currentCharacterGovernmentAuthorizations');
    return authorizationSet &&
           _.contains(
             authorizationSet[authorization_level],
             authorization_type
           );
  },
};
