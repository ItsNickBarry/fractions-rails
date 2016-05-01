Fractions.Views.ElectoratesNew = Backbone.CompositeView.extend({
  template: JST['fraction_component_new'],
  className: 'fractions-object-element fractions-object-new fractions-object-electorate',

  events: {
    'click button#executable': 'addSubviewForElectoratesExecutableForm',
    // 'click button#callable': 'addSubviewForElectoratesCallableForm',
    // 'click button#votable': 'addSubviewForElectoratesVotableForm',
  },

  initialize: function (options) {
    this.fraction = options.fraction;
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
      authorizer: this.fraction,
      authorization_type: 'electorate_create'
    });
    this.addSubview('.authorization-buttons', view);
  },

  addSubviewForElectoratesExecutableForm: function () {
    var view = new Fractions.Views.ElectoratesExecutableForm({
      fraction: this.fraction,
      collection: this.collection
    });
    this.subviews('.form-container').forEach(function (subview) {
      subview.remove();
    });
    this.addSubview('.form-container', view);
  },
});
