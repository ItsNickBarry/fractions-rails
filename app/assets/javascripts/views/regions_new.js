Fractions.Views.RegionsNew = Backbone.CompositeView.extend({
  template: JST['fraction_component_new'],
  className: 'fractions-object new region',

  events: {
    'click button#executable': 'addSubviewForRegionsExecutableForm',
    // 'click button#callable': 'addSubviewForRegionsCallableForm',
    // 'click button#votable': 'addSubviewForRegionsVotableForm',
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
      authorization_type: 'region_create'
    });
    this.addSubview('.authorization-buttons', view);
  },

  addSubviewForRegionsExecutableForm: function () {
    var view = new Fractions.Views.RegionsExecutableForm({
      fraction: this.fraction,
      collection: this.collection
    });
    this.subviews('.form-container').forEach(function (subview) {
      subview.remove();
    });
    this.addSubview('.form-container', view);
  },
});
