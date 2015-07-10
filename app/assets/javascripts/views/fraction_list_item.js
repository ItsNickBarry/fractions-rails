Fractions.Views.FractionListItem = Backbone.View.extend({
  template: JST['fraction_list_item'],
  className: 'fractions-object-element fractions-object-list-item fractions-object-fraction',

  events: {
    
  },

  initialize: function () {
    this.listenTo(this.model, 'sync', this.render);
  },

  render: function () {
    var content = this.template({ fraction: this.model });
    this.$el.html(content);
    return this;
  },
});
