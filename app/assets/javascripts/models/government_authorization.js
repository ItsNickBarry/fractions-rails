Fractions.Models.GovernmentAuthorization = Backbone.Model.extend(
  Fractions.Concerns.Associable
).extend({

  class: 'GovernmentAuthorization',
  urlFragmentRoot: '/government_authorizations',
  urlRoot: '/api/government_authorizations',
});

(function () {
  this.belongsTo('authorizee', { polymorphic: true });
  this.belongsTo('authorizer', { polymorphic: true });
}).call(Fractions.Models.GovernmentAuthorization.prototype);
