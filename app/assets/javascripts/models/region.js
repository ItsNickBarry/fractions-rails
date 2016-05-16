Fractions.Models.Region = Backbone.ShallowNestedModel.extend(
  Fractions.Concerns.Associable
).extend(
  Fractions.Concerns.Routable
).extend({

  class: 'Region',
  urlFragmentRoot: '/regions',
  urlRoot: '/api/regions',
});

(function () {
  this.belongsTo('fraction');
}).call(Fractions.Models.Region.prototype);
