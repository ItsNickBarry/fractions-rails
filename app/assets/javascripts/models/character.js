Fractions.Models.Character = Backbone.Model.extend({
  urlRoot: '/api/characters',

  // parse: function (response) {
  //   if (response.characters) {
  //     this.characters().set(response.characters, { parse: true });
  //     delete response.characters;
  //   }
  //   return response;
  // },
});
