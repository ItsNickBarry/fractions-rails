Fractions.Models.Session = Backbone.Model.extend({
  url: '/api/session',

  // defaults: {
  //   id: 0,
  //   username: '',
  //   uuid: '',
  //   governmentAuthorizations: []
  // }

  parse: function (response) {
    // TODO parse current_user server_authorizations
    if (response.current_character) {
      this.currentCharacter().set(response.current_character);
      delete response.current_character;
    }
    if (response.current_user) {
      this.currentUser().set(response.current_user);
      delete response.current_user;
    }
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
