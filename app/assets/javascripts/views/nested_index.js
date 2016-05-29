Fractions.Views.NestedIndex = Backbone.CompositeView.extend({
  template: JST['nested_index'],

  initialize: function (options) {

    // TODO make list sortable
    // TODO not just for Fraction components

    this.addSubview('.list', new Fractions.Views.List({
      collection: this.collection,
    }));

    this.addSubview('.form-container', new Fractions.Views.AuthorizableForm({
      model: this.model,
      collection: this.collection,
      authorizationType: this.collection.model.prototype.class.toLowerCase() + '_create',
      subFormTemplate: _.pluralize(this.collection.model.prototype.class.toLowerCase()) + '_new',
    }));
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
});
