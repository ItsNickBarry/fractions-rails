Fractions.Views.UserShow = Backbone.CompositeView.extend({
  template: JST["user_show"],

  events: {

  },

  initialize: function () {
    this.collection = this.model.characters();
    this.listenTo(this.model, "sync", this.render);
    this.listenTo(this.collection, "add remove", this.addCharacter);
  },

  render: function () {
    var content = this.template({ user: this.model });
    this.$el.html(content);
    // this.renderCharacterForm();
    this.renderCharacters();
    return this;
  },

  // renderCharacterForm: function () {
  //   var view = new Fractions.Views.CharacterForm({ collection: this.collection });
  //   this.addSubview('#project-form', view);
  // },

  renderCharacters: function () {
    this.collection.each(this.addCharacter.bind(this));
  },

  addCharacter: function (project) {
    var view = new Fractions.Views.CharacterListItem({ model: project});
    this.addSubview('#projects', view);
  }
});
