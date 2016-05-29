Fractions.Views.FractionInformation = Backbone.View.extend({
  template: JST['fraction_information'],

  events: {
    'submit form': 'submit',
    'click button.edit': 'edit',
    'click button.preview': 'preview',
  },

  render: function () {
    var content = this.template({
      fraction: this.model,
      description: markdown.toHTML(this.model.get('description')),
    });
    this.$el.html(content);
    return this;
  },

  submit: function (event) {
    event.preventDefault();
    var params = $(event.currentTarget).serializeJSON();
    this.model.save(params, {
      wait: true,
      success: function () {
        this.render();
      }.bind(this),
    });
  },

  edit: function (event) {
    alert('asdf');
  },

  preview: function (event) {
    alert('asdf');
  },
});
