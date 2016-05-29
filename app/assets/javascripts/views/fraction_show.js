Fractions.Views.FractionShow = Backbone.CompositeView.extend({
  template: JST['fraction_show'],

  events: {
    'click .tab a': 'clickTab',
  },

  initialize: function () {
    this.listenTo(this.model, 'sync', this.render);
    window.fr = this.model;
  },

  render: function () {
    var content = this.template({
      fraction: this.model,
    });
    this.$el.html(content);

    this.setSubview('.tab-content', new Fractions.Views.FractionInformation({
      model: this.model,
    }));
    this.attachSubviews();
    return this;
  },

  clickTab: function (event) {
    event.preventDefault();
    $('.tab.selected').removeClass('selected');
    $(event.target.parentElement.parentElement).addClass('selected');

    var name = event.target.innerHTML.toLowerCase();

    var view;
    switch (name) {
      case 'information':
        view = new Fractions.Views.FractionInformation({
          model: this.model,
        });
        break;
      case 'children':
      case 'electorates':
      case 'positions':
      case 'regions':
        view = new Fractions.Views.NestedIndex({
          model: this.model,
          collection: this.model[name](),
        });
        break;
    }
    this.setSubview('.tab-content', view);
  },
});
