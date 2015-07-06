Fractions.Views.UserShow = Backbone.CompositeView.extend({
  template: JST["user_show"],

  events: {

  },

  initialize: function () {
    this.characters = this.model.characters();
    this.listenTo(this.model, "sync", this.render);
    this.listenTo(this.characters, "add remove", this.addCharacter);
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

  addCharacter: function (project) {
    var view = new Fractions.Views.CharacterListItem({ model: project});
    this.addSubview('#characters', view);
  }
});
