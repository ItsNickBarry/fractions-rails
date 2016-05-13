Fractions.Views.ExecutableForm = Backbone.View.extend({
  events: {
    'submit form': 'submit'
  },

  initialize: function (options) {
    this.noun = options.noun;
    this.fraction = options.fraction;
    this.template = function (options) {
      return JST[_.pluralize(this.noun) + '_new_form'](options);
    };
  },

  render: function () {
    var content = this.template({
      fraction: this.fraction
    });
    this.$el.html(content);
    return this;
  },

  submit: function (event) {
    var view = this;
    event.preventDefault();

    var params = $(event.currentTarget).serializeJSON();
    this.collection.create(params, {
      wait: true,
      success: function () {
        view.remove();
      }
    });
  }
});
