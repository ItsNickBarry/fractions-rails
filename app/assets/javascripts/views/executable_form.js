Fractions.Views.ExecutableForm = Backbone.View.extend({
  className: 'fractions-object new',

  events: {
    'submit form': 'submit'
  },

  initialize: function (options) {
    this.noun = options.noun;
    this.fraction = options.fraction;
    this.template = function () {
      return JST[_.pluralize(this.noun) + '_new_form']();
    };
  },

  render: function () {
    var content = this.template();
    this.$el.html(content);
    return this;
  },

  submit: function (event) {
    var view = this;
    event.preventDefault();

    var params = $(event.currentTarget).serializeJSON();
    this.collection.create(params[this.noun], {
      wait: true,
      success: function () {
        view.remove();
      }
    });
  }
});
