Fractions.Collections.FractionRegions = Backbone.Collection.extend({
  model: Fractions.Models.Region,

  initialize: function (options) {
    this.fraction = options.fraction;
    this.url = this.fraction.url() + '/regions';
  }
});
