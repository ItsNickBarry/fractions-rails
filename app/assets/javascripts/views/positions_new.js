Fractions.Views.PositionsNew = Backbone.CompositeView.extend({
  template: JST['fraction_component_new'],
  className: 'fractions-object new position',

  events: {
    'click button#executable': 'addSubviewForPositionsExecutableForm',
    // 'click button#callable': 'addSubviewForPositionsCallableForm',
    // 'click button#votable': 'addSubviewForPositionsVotableForm',
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
      authorization_type: 'position_create'
    });
    this.addSubview('.authorization-buttons', view);
  },

  addSubviewForPositionsExecutableForm: function () {
    var view = new Fractions.Views.PositionsExecutableForm({
      fraction: this.fraction,
      collection: this.collection
    });
    this.subviews('.form-container').forEach(function (subview) {
      subview.remove();
    });
    this.addSubview('.form-container', view);
  },
});
