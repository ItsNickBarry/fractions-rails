Fractions.Views.CharacterShow = Backbone.CompositeView.extend({
  template: JST["character_show"],

  events: {

  },

  initialize: function () {
    // this.collection = this.model.characters();
    this.listenTo(this.model, "sync", this.render);
    // this.listenTo(this.collection, "add remove", this.addCharacter);
  },

  render: function () {
    var content = this.template({ user: this.model });
    this.$el.html(content);
    return this;
  },
});
