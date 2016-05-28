Fractions.Views.FractionShow = Backbone.CompositeView.extend({
  template: JST['fraction_show'],

  events: {
    'click .tab a': 'clickTab'
  },

  initialize: function () {
    this.children = this.model.children();
    this.electorates = this.model.electorates();
    this.positions = this.model.positions();
    this.regions = this.model.regions();

    this.listenTo(this.model, 'sync', this.render);
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

    var name = event.target.innerHTML.toLowerCase();

    this.subviews('.tab-content').forEach(function (subview) {
      subview.remove();
    });

    var view;
    switch (name) {
      case 'information':
        // TODO fraction information view
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
    this.addSubview('.tab-content', view);
  },
});
