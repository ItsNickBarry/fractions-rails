Fractions.Models.Session = Backbone.Model.extend({
  url: '/api/session',

  // defaults: {
  //   id: 0,
  //   username: '',
  //   uuid: '',
  //   governmentAuthorizations: []
  // }

  parse: function (response) {
    // TODO parse currentCharacter and currentUser
  },

  currentCharacter: function () {
    if (!this._current_character) {
      this._current_character = new Fractions.Models.Character();
    }
    return this._current_character;
  },

  currentUser: function () {
    if (!this._current_user) {
      this._current_user = new Fractions.Models.User();
    }
    return this._current_user;
  }
});
