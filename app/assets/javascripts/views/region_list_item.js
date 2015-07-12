Fractions.Views.RegionListItem = Backbone.View.extend({
  template: JST['list_item'],
  className: 'fractions-object-element fractions-object-list-item fractions-object-region',

  events: {
    'click': 'show'
  },

  initialize: function () {
    this.listenTo(this.model, 'sync', this.render);
  },

  render: function () {
    var content = this.template({ model: this.model });
    this.$el.html(content);
    return this;
  },

  show: function (event) {
    Backbone.history.navigate('regions/' + this.model.get('id'), { trigger: true });
  }
});
