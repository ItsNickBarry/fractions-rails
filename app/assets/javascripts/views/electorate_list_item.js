Fractions.Views.ElectorateListItem = Backbone.View.extend({
  template: JST['list_item'],
  className: 'fractions-object-element fractions-object-list-item fractions-object-electorate',

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
    Backbone.history.navigate('/electorates/' + this.model.get('id'), { trigger: true });
  }
});
