Fractions.Views.CharacterShow = Backbone.CompositeView.extend({
  template: JST['character_show'],
  className: 'fractions-object-element fractions-object-TYPEcharacter-show fractions-object-character',

  events: {

  },

  initialize: function () {
    // this.collection = this.model.characters();
    this.listenTo(this.model, 'sync', this.render);
    // this.listenTo(this.collection, 'add remove', this.addCharacter);
  },

  render: function () {
    var content = this.template({ character: this.model });
    this.$el.html(content);
    return this;
  },
});
