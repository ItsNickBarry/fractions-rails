Fractions.Views.FractionComponentIndex = Backbone.CompositeView.extend({
  template: JST['fraction_component_index'],
  className: 'fractions-object index',

  initialize: function (options) {
    this.noun = options.noun;
    this.collection = this.model[this.noun + 's']();
    this.className += ' ' + this.noun;
    this.addSubviewForFractionComponentList();
  },

  render: function () {
    var content = this.template({ fraction: this.model, noun: this.noun });
    this.$el.html(content);
    this.attachSubviews();
    return this;
  },

  addSubviewForFractionComponentList: function () {
    var view = new Fractions.Views.List({ collection: this.collection });
    this.addSubview('.list', view);
  },
});
