Fractions.Models.Character = Backbone.Model.extend({
  urlRoot: '/api/characters',

  parse: function (response) {
    if (response.fractions) {
      this.fractions().set(response.fractions, { parse: true });
      delete response.fractions;
    }
    if (response.user) {
      this.user().set(response.user, { parse: true });
      delete response.user;
    }
    return response;
  },

  // electorates: function () {
  //   if (!this._electorates) {
  //     this._electorates = new Fractions.Collections.Electorates();
  //   }
  //   return this._electorates;
  // },

  fractions: function () {
    if (!this._fractions) {
      this._fractions = new Fractions.Collections.Fractions();
    }
    return this._fractions;
  },

  user: function () {
    if (!this._user) {
      this._user = new Fractions.Models.User();
    }
    return this._user;
  }
});
