Fractions.Views.NestedIndex = Backbone.CompositeView.extend({
  template: JST['nested_index'],

  initialize: function (options) {

    // TODO make list sortable
    // TODO not just for Fraction components

    this.name = options.name;
    this.noun = options.noun || this.name;
    this.collection = this.model[_.camelize(this.name)]();
    this.addSubviewForList();
    this.addSubviewForNew();
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

  addSubviewForList: function () {
    var view = new Fractions.Views.List({ collection: this.collection });
    this.addSubview('.list', view);
  },

  addSubviewForNew: function () {
    var view = new Fractions.Views.FractionComponentNew({
      collection: this.collection,
      fraction: this.model,
      name: this.name,
      noun: this.noun
    });
    this.addSubview('.fraction-component-new', view);
  }
});
