Fractions.Views.UserShow = Backbone.CompositeView.extend({
  template: JST['user_show'],
  className: 'fractions-object-element fractions-object-show fractions-object-user',

  events: {

  },

  initialize: function () {
    this.characters = this.model.characters();
    this.listenTo(this.model, 'sync', this.render);
    // TODO character does not show up in list when added
    this.listenTo(this.characters, 'add remove', this.addCharacter);
  },

  render: function () {
    var content = this.template({ user: this.model });
    this.$el.html(content);
    this.renderCharactersNew();
    this.renderCharacters();
    return this;
  },

  renderCharactersNew: function () {
    var view = new Fractions.Views.CharactersNew({ collection: this.characters });
    this.addSubview('#characters-new', view);
  },

  renderCharacters: function () {
    this.characters.each(this.addCharacter.bind(this));
  },

  addCharacter: function (character) {
    var view = new Fractions.Views.CharacterListItem({ model: character});
    this.addSubview('#characters', view);
  }
});
