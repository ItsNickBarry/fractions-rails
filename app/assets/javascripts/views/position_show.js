Fractions.Views.PositionShow = Backbone.CompositeView.extend({
  template: JST['position_show'],
  className: 'fractions-object-element fractions-object-show fractions-object-position',

  events: {

  },

  initialize: function () {
    this.characters = this.model.characters();
    this.listenTo(this.model, 'sync', this.render);
    this.listenTo(this.characters, 'add remove', this.addCharacter);
  },

  render: function () {
    var content = this.template({ position: this.model });
    this.$el.html(content);
    // this.renderCharactersNew();
    this.renderCharacters();
    return this;
  },

  // renderCharactersNew: function () {
  //   var view = new Positions.Views.CharactersNew({ collection: this.characters, position: this.model });
  //   this.addSubview('#characters-new', view);
  // },

  renderCharacters: function () {
    this.characters.each(this.addCharacter.bind(this));
  },

  addCharacter: function (character) {
    var view = new Fractions.Views.CharacterListItem({ model: character });
    this.addSubview('#characters', view);
  }
});
