Fractions.Models.Character = Backbone.Model.extend(
  Fractions.Concerns.Associable
).extend(
  Fractions.Concerns.Routable
).extend({

  class: 'Character',
  urlFragmentRoot: '/characters',
  urlRoot: '/api/characters',

  initialize: function () {
    this.belongsTo('user');
    this.hasMany('foundedFractions', { className: 'Fraction' });
    this.hasMany('fractions');
  },
});
