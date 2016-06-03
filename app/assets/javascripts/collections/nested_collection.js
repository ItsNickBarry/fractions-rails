Fractions.Collections.NestedCollection = Backbone.Collection.extend(
  Fractions.Concerns.Routable
).extend({

  initialize: function (options) {
    this.name = options.name;
    this.model = options.model;
    this.parentModel = options.parentModel;
    this.url = this.parentModel.url() + '/' + _.underscored(_.pluralize(this.model.prototype.class));
  },
});
