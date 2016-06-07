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

  executable: function (authorizationType) {
    return this._authorizes('executable', authorizationType);
  },

  callable: function (authorizationType) {
    return this._authorizes('callable', authorizationType);
  },

  votable: function (authorizationType) {
    return this._authorizes('votable', authorizationType);
  },

  _authorizes: function (authorizationLevel, authorizationType) {
    var privateName = '_' + authorizationLevel + '_' + authorizationType;
    if (typeof this[privateName] === 'undefined') {
      this[privateName] = this.governmentAuthorizationsGiven().any(function (authorization) {
        return authorization.get('currentCharacter') &&
          authorization.get('authorizationType') === authorizationType &&
          authorization.authorizee().class === {
            executable: 'Position',
            callable: 'Electorate',
            votable: 'Electorate',
          }[authorizationLevel];
      });
    }
    return this[privateName];
  },

  // _authorizes: function (authorizationLevel, authorizationType) {
  //   var authorizationSet = this.get('currentCharacterGovernmentAuthorizations');
  //   return authorizationSet &&
  //          _.contains(
  //            authorizationSet[authorizationLevel],
  //            authorizationType
  //          );
  // },
};
