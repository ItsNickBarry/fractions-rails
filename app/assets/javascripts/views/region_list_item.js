Fractions.Views.RegionListItem = Backbone.View.extend({
  template: JST['region_list_item'],
  className: 'fractions-object-element fractions-object-list-item fractions-object-region',

  events: {

  },

  initialize: function () {
    this.listenTo(this.model, 'sync', this.render);
  },

  render: function () {
    var content = this.template({ region: this.model });
    this.$el.html(content);
    return this;
  },
});
