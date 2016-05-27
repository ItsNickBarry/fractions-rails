Fractions.Views.ListItem = Backbone.View.extend({
  template: JST['list_item'],
  tagName: 'li',

  events: {
    'click': 'show'
  },

  initialize: function (options) {
    this.listenTo(this.model, 'sync', this.render);
  },

  render: function () {
    var content = this.template({
      model: this.model
    });
    this.$el.html(content);
    return this;
  },

  show: function (event) {
    Backbone.history.navigate(
      this.model.urlFragmentRoot + '/' + this.model.get('id'),
      { trigger: true }
    );
  }
});
