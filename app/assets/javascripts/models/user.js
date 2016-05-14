var User = Fractions.Models.User = Backbone.Model.extend(
  Fractions.Concerns.Associable
).extend(
  Fractions.Concerns.Routable
).extend({

  class: 'User',
  urlFragmentRoot: '/users',
  urlRoot: '/api/users',
});

(function () {
  this.hasMany('characters');
}).call(User.prototype);
