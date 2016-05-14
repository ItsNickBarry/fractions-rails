Fractions.Models.Fraction = Backbone.Model.extend(
  Fractions.Concerns.Governable
).extend(
  Fractions.Concerns.Routable
).extend(
  Fractions.Concerns.Associable
).extend({

  class: 'Fraction',
  urlFragmentRoot: '/fractions',
  urlRoot: '/api/fractions',

  initialize: function () {
    this.belongsTo('founder', { polymorphic: true });
    this.belongsTo('parent', { className: 'Fraction' });
    this.belongsTo('root', { className: 'Fraction' });
    this.hasMany('electorates');
    this.hasMany('positions');
    this.hasMany('regions');
    this.hasMany('children', { className: 'Fraction' });
    this.hasMany('foundedFractions', { className: 'Fraction' });
  },
});
