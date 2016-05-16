Fractions.Models.Fraction = Backbone.Model.extend(
  Fractions.Concerns.Associable
).extend(
  Fractions.Concerns.Governable
).extend(
  Fractions.Concerns.Routable
).extend({

  class: 'Fraction',
  urlFragmentRoot: '/fractions',
  urlRoot: '/api/fractions',
});

(function () {
  this.belongsTo('founder', { polymorphic: true });
  this.belongsTo('parent', { className: 'Fraction' });
  this.belongsTo('root', { className: 'Fraction' });
  this.hasMany('electorates');
  this.hasMany('positions');
  this.hasMany('regions');
  this.hasMany('children', { className: 'Fraction' });
  this.hasMany('foundedFractions', { className: 'Fraction' });
}).call(Fractions.Models.Fraction.prototype);
