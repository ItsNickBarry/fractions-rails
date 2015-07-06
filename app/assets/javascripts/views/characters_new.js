Fractions.Views.CharactersNew = Backbone.View.extend({
  template: JST["characters_new"],
  // tagName: 'form',
  // className: 'form-list-item',

  events: {
    'submit form': 'submit'
  },

  render: function () {
    var content = this.template();
    this.$el.html(content);
    return this;
  },

  submit: function (event) {
    // event.preventDefault();
    // var params = this.$el.serializeJSON()["character"];
    // this.collection.create(params, { wait: true })
    // this.render();
    // event.preventDefault();
    // debugger
    // var params = $(event.currentTarget).serializeJSON()["character"];
    // var newCharacter = new Fractions.Models.Character(params);
    // var characters = this.collection;
    // newCharacter.save({}, {
    //   success: function () {
    //     characters.add(newCharacter)
    //   }
    // })

    var view = this;
    event.preventDefault();

    var params = $(event.currentTarget).serializeJSON();
    var character = new Fractions.Models.Character(params["character"]);
    character.save({}, {
      success: function () {
        view.collection.add(character);
        // re-render to clear form/preview
        view.render();
      }
    });
  }
});
