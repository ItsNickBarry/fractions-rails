Fractions.Collections.FractionElectorates = Backbone.Collection.extend({
  model: Fractions.Models.Electorate,

  initialize: function (options) {
    this.fraction = options.fraction;
    this.url = this.fraction.url() + '/electorates';
  }
});
