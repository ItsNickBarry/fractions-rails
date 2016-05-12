Fractions.Collections.FractionPositions = Backbone.Collection.extend({
  model: Fractions.Models.Position,

  initialize: function (options) {
    this.fraction = options.fraction;
    this.url = this.fraction.url() + '/positions';
  }
});
