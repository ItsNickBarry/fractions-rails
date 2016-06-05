Fractions.Views.GovernmentAuthorizationIndex = Backbone.CompositeView.extend({
  template: JST['government_authorization_index'],

  initialize: function () {
    _.each(this.model.governmentAuthorizationTypes(), function (type) {
      this.addSubview('.list', new Fractions.Views.GovernmentAuthorizationRow({
        model: this.model,
        authorizationType: type,
      }));
    }.bind(this));

    this.addSubview('.form-container', new Fractions.Views.AuthorizableForm({
      model: this.model,
      collection: this.model.governmentAuthorizationsGiven(),
      authorizationType: 'government_authorization_create',
      subFormTemplate: 'government_authorizations_new',
    }));
  },

  render: function () {
    var content = this.template({
      model: this.model,
      governmentAuthorizationsGiven: this.model.governmentAuthorizationsGiven(),
    });
    this.$el.html(content);
    this.attachSubviews();
    return this;
  },
});
