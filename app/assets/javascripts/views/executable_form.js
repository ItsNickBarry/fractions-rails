Fractions.Views.ExecutableForm = Backbone.View.extend({
  className: 'fractions-object new',

  events: {
    'submit form': 'submit'
  },

  initialize: function (options) {
    this.noun = options.noun;
    this.className += ' ' + this.noun;
    this.fraction = options.fraction;
    this.template = function () {
      return JST[this.noun + 's_new_form']();
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
    params[this.noun].fraction_id = this.fraction.get('id');
    this.collection.create(params[this.noun], {
      wait: true,
      success: function () {
        view.remove();
      }
    });
  }
});
