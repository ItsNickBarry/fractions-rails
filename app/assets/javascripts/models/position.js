Fractions.Models.Position = Backbone.ShallowNestedModel.extend(
  Fractions.Concerns.Associable
).extend(
  Fractions.Concerns.Routable
).extend({

  class: 'Position',
  urlFragmentRoot: '/positions',
  urlRoot: '/api/positions',
});

(function () {
  this.belongsTo('fraction');
  this.hasMany('members', { className: 'Character' });
}).call(Fractions.Models.Position.prototype);
