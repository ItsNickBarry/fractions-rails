Fractions.Views.PositionListItem = Backbone.View.extend({
  template: JST['position_list_item'],
  className: 'fractions-object-element fractions-object-list-item fractions-object-position',

  events: {
    // 'click': 'show'
  },

  initialize: function () {
    this.listenTo(this.model, 'sync', this.render);
  },

  render: function () {
    var content = this.template({ position: this.model });
    this.$el.html(content);
    return this;
  },

  // show: function (event) {
  //   Backbone.history.navigate('/positions/' + this.model.get('id'), { trigger: true });
  // }
});
