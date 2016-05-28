Fractions.Views.AuthorizableForm = Backbone.View.extend({
  template: JST['authorizable_form'],

  events: {
    'submit form': 'submit',
    'click button.expand': 'toggleForm',
  },

  initialize: function (options) {
    // this.template = function (options) {
    //   return JST[_.pluralize(this.collection.model.prototype.class.toLowerCase()) + '_new'](options);
    // };
  },

  render: function () {
    var noun = this.collection.model.prototype.class.toLowerCase();
    var authorization_type = noun + '_create';

    // TODO separate form for non-governable
    var content = this.template({
      authorizer: this.model,
      executable: this.model.governable && this.model.executable(authorization_type),
      callable:   this.model.governable && this.model.callable(authorization_type),
      votable:    this.model.governable && this.model.votable(authorization_type),
      collection: this.collection,
      formInputs: JST[_.pluralize(noun) + '_new']({
        authorizer: this.model,
      }),
    });
    this.$el.html(content);
    return this;
  },

  submit: function (event) {
    event.preventDefault();
    var params = $(event.currentTarget).serializeJSON();
    this.collection.create(params, {
      wait: true,
      success: function () {
        this.render();
      }.bind(this),
    });
  },

  toggleForm: function () {
    this.$el.find('form').toggleClass('hidden');
    this.$el.find('button.expand').toggleClass('selected');
  },
});
