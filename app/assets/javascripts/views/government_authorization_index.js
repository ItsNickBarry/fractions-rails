Fractions.Views.GovernmentAuthorizationIndex = Backbone.CompositeView.extend({
  template: JST['government_authorization_index'],

  render: function () {
    var content = this.template({
      authorizer: this.model,
      collection: this.collection,
    });
    this.$el.html(content);
    this.attachSubviews();
    return this;
  },
});
