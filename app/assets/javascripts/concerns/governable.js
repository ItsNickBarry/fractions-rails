Fractions.Concerns.Governable = {
  governable: true,
  
  executable: function (authorization_type) {
    return this._authorizes(
      'executable',
      authorization_type
    );
  },

  callable: function (authorization_type) {
    return this._authorizes(
      'callable',
      authorization_type
    );
  },

  votable: function (authorization_type) {
    return this._authorizes(
      'votable',
      authorization_type
    );
  },

  _authorizes: function (authorization_level, authorization_type) {
    var authorizationSet = this.get(
      'current_character_government_authorizations'
    );
    return authorizationSet &&
           _.contains(
             authorizationSet[authorization_level],
             authorization_type
           );
  },
};
