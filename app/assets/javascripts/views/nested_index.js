Fractions.Views.NestedIndex = Backbone.CompositeView.extend({
  template: JST['nested_index'],

  initialize: function (options) {

    // TODO make list sortable
    // TODO not just for Fraction components

    this.addSubviewForList(options);
    this.addSubviewForNestedModelFormContainer(options);
  },

  render: function () {
    var content = this.template({
      model: this.model,
      name: _.titleize(_.humanize(this.collection.name))
    });
    this.$el.html(content);
    this.attachSubviews();
    return this;
  },

  addSubviewForList: function (options) {
    var view = new Fractions.Views.List(options);
    this.addSubview('.list', view);
  },

  addSubviewForNestedModelFormContainer: function (options) {
    var view = new Fractions.Views.NestedModelFormContainer(options);
    this.addSubview('.form-container', view);
  }
});
