Fractions.Collections.Characters = Backbone.Collection.extend({
  model: Fractions.Models.Character,
  url: 'api/characters',

  getOrFetch: function (id) {
    var characters = this;

    var character;
    if (character = this.get(id)) {
      character.fetch();
    } else {
      character = new Fractions.Models.Character({ id: id });
      character.fetch({
        success: function () { characters.add(character); }
      });
    }

    return character;
  }
});
