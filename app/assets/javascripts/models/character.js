Fractions.Models.Character = Backbone.Model.extend({
  urlRoot: '/api/characters',

  parse: function (response) {
    if (response.user) {
      this.user().set(response.user, { parse: true });
      delete response.user;
    }
    return response;
  },

  user: function () {
    if (!this._user) {
      this._user = new Fractions.Models.User();
    }
    return this._user;
  }
});
