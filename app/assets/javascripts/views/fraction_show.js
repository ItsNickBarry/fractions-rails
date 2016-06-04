Fractions.Views.FractionShow = Backbone.CompositeView.extend({
  template: JST['fraction_show'],

  events: {
    'click .tab a': 'clickTab',
  },

  initialize: function () {
    this.listenTo(this.model, 'sync', this.render);

    this.setSubview('.fraction-information', new Fractions.Views.FractionInformation({
      model: this.model,
    }));
  },

  render: function () {
    var content = this.template({
      fraction: this.model,
    });
    this.$el.html(content);
    this.attachSubviews();
    return this;
  },

  clickTab: function (event) {
    event.preventDefault();
    $('.tab.selected').removeClass('selected');
    $(event.target.parentElement.parentElement).addClass('selected');

    var view = new Fractions.Views.NestedIndex({
      model: this.model,
      collection: this.model[event.target.innerHTML.toLowerCase()](),
    });
    this.setSubview('.tab-content', view);
  },
});
