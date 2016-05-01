Fractions.Views.ElectoratesNew = Backbone.CompositeView.extend({
  template: JST['fraction_component_new'],
  className: 'fractions-object-element fractions-object-new fractions-object-electorate',

  events: {
    'click button#executable': 'renderExecutable',
    // 'click button#callable': 'renderCallable',
    // 'click button#votable': 'renderVotable',
    'submit form': 'submit'
  },

  initialize: function (options) {
    this.fraction = options.fraction;
    this.addSubViewForAuthorizationButtons();
  },

  render: function () {
    var content = this.template();
    this.$el.html(content);
    this.attachSubviews();
    return this;
  },

  addSubViewForAuthorizationButtons: function () {
    var view = new Fractions.Views.AuthorizationButtons({
      authorizer: this.fraction,
      authorization_type: 'electorate_create'
    });
    this.addSubview('.authorization-buttons', view);
  },

  renderExecutable: function () {
    var view = new Fractions.Views.ElectoratesExecutableForm({
      fraction: this.fraction
    });
    this.subviews('.form-container').forEach(function (subview) {
      subview.remove();
    });
    this.addSubview('.form-container', view);
  },

  submit: function (event) {
    var view = this;
    event.preventDefault();

    var params = $(event.currentTarget).serializeJSON();
    params.electorate.fraction_id = this.fraction.escape('id');
    this.collection.create(params['electorate'], { wait: true })
    this.render();
  }
});
