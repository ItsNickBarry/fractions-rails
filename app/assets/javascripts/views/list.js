Fractions.Views.List = Backbone.View.extend({
  template: JST['list'],
  tagName: 'ul',

  initialize: function (options) {
    // TODO pagination or overflow
    // TODO only works for objects with 'name' attribute
    this.listenTo(this.collection, 'add remove', this.render);
  },

  render: function () {
    var content = this.template({
      collection: this.collection
    });
    this.$el.html(content);
    return this;
  },

});
