Fractions.Models.Position = Backbone.ShallowNestedModel.extend(
  Fractions.Concerns.Associable
).extend(
  Fractions.Concerns.Routable
).extend({

  class: 'Position',
  urlFragmentRoot: '/positions',
  urlRoot: '/api/positions',

  initialize: function () {
    this.belongsTo('fraction');
    this.hasMany('characters');
  },
});
