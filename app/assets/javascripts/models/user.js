Fractions.Models.User = Backbone.Model.extend({
  urlRoot: '/api/users',

  parse: function (response) {
    if (response.characters) {
      this.characters().set(response.characters, { parse: true });
      delete response.characters;
    }
    return response;
  },

  characters: function () {
    if (!this._projects) {
      this._projects = new Fractions.Collections.Characters([], { user: this })
    }
    return this._projects;
  }
});
