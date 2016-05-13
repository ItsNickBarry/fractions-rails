Fractions.Views.NestedModelFormContainer = Backbone.CompositeView.extend({
  template: JST['nested_model_form_container'],

  events: {
    'click button#executable': 'addSubviewForExecutableForm',
    // 'click button#callable': 'addSubviewForCallableForm',
    // 'click button#votable': 'addSubviewForVotableForm',
  },

  initialize: function (options) {
    this.addSubviewForAuthorizationButtons();
  },

  render: function () {
    var content = this.template();
    this.$el.html(content);
    this.attachSubviews();
    return this;
  },

  addSubviewForAuthorizationButtons: function () {
    var view = new Fractions.Views.AuthorizationButtons({
      authorizer: this.model,
      authorization_type: this.collection.model.prototype.class.toLowerCase() + '_create'
    });
    this.addSubview('.authorization-buttons', view);
  },

  addSubviewForExecutableForm: function () {
    var view = new Fractions.Views.ExecutableForm({
      model: this.model,
      collection: this.collection,
    });
    this.subviews('.form').forEach(function (subview) {
      subview.remove();
    });
    this.addSubview('.form', view);
  },
});
