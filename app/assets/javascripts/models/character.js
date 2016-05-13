Fractions.Models.Character = Backbone.Model.extend(
  Fractions.Concerns.Routable
).extend({
  
  class: 'Character',
  urlFragmentRoot: '/characters',
  urlRoot: '/api/characters',

  parse: function (response) {
    if (response.founded_fractions) {
      this.foundedFractions().set(response.founded_fractions, { parse: true });
      delete response.founded_fractions;
    }
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

  foundedFractions: function () {
    if (!this._founded_fractions) {
      this._founded_fractions = new Fractions.Collections.Fractions();
    }
    return this._founded_fractions;
  },

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
