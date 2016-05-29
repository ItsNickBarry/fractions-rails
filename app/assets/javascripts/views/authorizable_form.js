Fractions.Views.AuthorizableForm = Backbone.View.extend({
  template: JST['authorizable_form'],

  events: {
    'submit form': 'submit',
    'click button.expand': 'toggleForm',
  },

  initialize: function (options) {
    this.authorizationType = options.authorizationType;
    this.subFormTemplate = options.subFormTemplate;
  },

  render: function () {
    // TODO separate form for non-governable
    var content = this.template({
      authorizer: this.model,
      executable: this.model.governable && this.model.executable(this.authorizationType),
      callable:   this.model.governable && this.model.callable(this.authorizationType),
      votable:    this.model.governable && this.model.votable(this.authorizationType),
      collection: this.collection,
      formInputs: JST[this.subFormTemplate]({
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
