Fractions.Views.ExecutableForm = Backbone.View.extend({
  events: {
    'submit form': 'submit'
  },

  initialize: function (options) {
    this.template = function (options) {
      return JST[_.pluralize(this.collection.model.prototype.class.toLowerCase()) + '_new_form'](options);
    };
  },

  render: function () {
    var content = this.template({
      model: this.model
    });
    this.$el.html(content);
    return this;
  },

  submit: function (event) {
    event.preventDefault();
    var view = this;
    var params = $(event.currentTarget).serializeJSON();
    this.collection.create(params, {
      wait: true,
      success: function () {
        view.remove();
      }
    });
  }
});
