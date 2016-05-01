Fractions.Views.AuthorizationButtons = Backbone.View.extend({
  template: JST['authorization_buttons'],

  initialize: function (options) {
    this.authorizer = options.authorizer;
    this.authorization_type = options.authorization_type;
  },

  render: function () {
    var content = this.template({
      authorizer: this.authorizer,
      authorization_type: this.authorization_type
    });
    this.$el.html(content);
    return this;
  }
});
