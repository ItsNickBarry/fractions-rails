Fractions.Views.ElectorateListItem = Backbone.View.extend({
  template: JST['electorate_list_item'],
  className: 'fractions-object-element fractions-object-list-item fractions-object-electorate',

  events: {
    // 'click': 'show'
  },

  initialize: function () {
    this.listenTo(this.model, 'sync', this.render);
  },

  render: function () {
    var content = this.template({ electorate: this.model });
    this.$el.html(content);
    return this;
  },

  // show: function (event) {
  //   Backbone.history.navigate('/electorates/' + this.model.get('id'), { trigger: true });
  // }
});
