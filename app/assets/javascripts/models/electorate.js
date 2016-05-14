var Electorate = Fractions.Models.Electorate = Backbone.ShallowNestedModel.extend(
  Fractions.Concerns.Associable
).extend(
  Fractions.Concerns.Routable
).extend({

  class: 'Electorate',
  urlFragmentRoot: '/electorates',
  urlRoot: '/api/electorates',
});

(function () {
  this.belongsTo('fraction');
  this.hasMany('members', { className: 'Position' });
}).call(Electorate.prototype);
