var Character = Fractions.Models.Character = Backbone.Model.extend(
  Fractions.Concerns.Associable
).extend(
  Fractions.Concerns.Routable
).extend({

  class: 'Character',
  urlFragmentRoot: '/characters',
  urlRoot: '/api/characters',
});

(function () {
  this.belongsTo('user');
  this.hasMany('foundedFractions', { className: 'Fraction' });
  this.hasMany('fractions');
}).call(Character.prototype);
