Fractions.Views.FractionShow = Backbone.CompositeView.extend({
  template: JST["fraction_show"],

  events: {

  },

  initialize: function () {
    // this.collection = this.model.fractions();
    this.listenTo(this.model, "sync", this.render);
    // this.listenTo(this.collection, "add remove", this.addFraction);
  },

  render: function () {
    var content = this.template({ fraction: this.model });
    this.$el.html(content);
    return this;
  },
});
