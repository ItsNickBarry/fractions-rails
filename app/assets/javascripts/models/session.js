Fractions.Models.Session = Backbone.Model.extend(
  Fractions.Concerns.Associable
).extend({

  url: '/api/session',

  initialize: function () {
    this.belongsTo('currentCharacter', { className: 'Character' });
    this.belongsTo('currentUser', { className: 'User' });
  },
});
