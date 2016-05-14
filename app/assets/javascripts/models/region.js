Fractions.Models.Region = Backbone.ShallowNestedModel.extend(
  Fractions.Concerns.Associable
).extend(
  Fractions.Concerns.Routable
).extend({

  class: 'Region',
  urlFragmentRoot: '/regions',
  urlRoot: '/api/regions',

  initialize: function () {
    this.belongsTo('fraction');
  },
});
