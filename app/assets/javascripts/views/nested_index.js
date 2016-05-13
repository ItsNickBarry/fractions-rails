Fractions.Views.NestedIndex = Backbone.CompositeView.extend({
  template: JST['nested_index'],

  initialize: function (options) {

    // TODO make list sortable
    // TODO not just for Fraction components

    this.name = options.name;
    this.collection = this.model[_.camelize(this.name)]();
    this.addSubviewForFractionComponentList();
    this.addSubviewForFractionComponentNew();
  },

  render: function () {
    var content = this.template({
      parentModel: this.model,
      name: _.titleize(this.name)
    });
    this.$el.html(content);
    this.attachSubviews();
    return this;
  },

  addSubviewForFractionComponentList: function () {
    var view = new Fractions.Views.List({ collection: this.collection });
    this.addSubview('.list', view);
  },

  addSubviewForFractionComponentNew: function () {
    var view = new Fractions.Views.FractionComponentNew({
      collection: this.collection,
      fraction: this.model,
      noun: this.name
    });
    this.addSubview('.fraction-component-new', view);
  }
});
