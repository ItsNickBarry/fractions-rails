Fractions.Views.GovernmentAuthorizationRow = Backbone.CompositeView.extend({
  template: JST['government_authorization_row'],

  initialize: function (options) {
    this.authorizationType = options.authorizationType;

    this.listenTo(this.model.governmentAuthorizationsGiven(), 'add remove', this.render);
  },

  render: function () {
    var electorates = this.model.governmentAuthorizationsGiven().filter(function (authorization) {
      return authorization.get('authorizationType') === this.authorizationType &&
             authorization.authorizee().class === 'Electorate';
    }.bind(this)).map(function (authorization) {
      return authorization.authorizee();
    });

    var positions = this.model.governmentAuthorizationsGiven().filter(function (authorization) {
      return authorization.get('authorizationType') === this.authorizationType &&
             authorization.authorizee().class === 'Position';
    }.bind(this)).map(function (authorization) {
      return authorization.authorizee();
    });


    var content = this.template({
      model: this.model,
      authorizationType: this.authorizationType,
      governmentAuthorizationsGiven: this.model.governmentAuthorizationsGiven(),
      electorates: electorates,
      positions: positions,
    });
    this.$el.html(content);
    this.attachSubviews();
    return this;
  },
});
