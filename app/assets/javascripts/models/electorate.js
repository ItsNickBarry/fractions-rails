Fractions.Models.Electorate = Backbone.ShallowNestedModel.extend(
  Fractions.Concerns.Associable
).extend(
  Fractions.Concerns.Routable
).extend({

  class: 'Electorate',
  urlFragmentRoot: '/electorates',
  urlRoot: '/api/electorates',

  initialize: function () {
    this.belongsTo('fraction');
    this.hasMany('characters');
  },
});
