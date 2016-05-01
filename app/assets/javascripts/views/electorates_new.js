Fractions.Views.ElectoratesNew = Backbone.View.extend({
  template: JST['electorates_new'],
  className: 'fractions-object-element fractions-object-new fractions-object-electorate',

  events: {
    'submit form': 'submit'
  },

  initialize: function (options) {
    this.fraction = options.fraction;
  },

  render: function () {
    var executable = this.fraction.executable('electorate_create')
    var content = this.template({
      executable: executable
    });
    this.$el.html(content);
    return this;
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
