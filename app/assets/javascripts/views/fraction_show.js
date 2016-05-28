Fractions.Views.FractionShow = Backbone.CompositeView.extend({
  template: JST['fraction_show'],

  events: {
    'click .tab a': 'displayTab'
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

  displayTab: function (event) {
    event.preventDefault();
    $('.tab.selected').removeClass('selected');
    $(event.target.parentElement.parentElement).addClass('selected');

    var view;
    switch (event.target.innerHTML) {
      case 'Information':
        // TODO fraction information view
        break;
      case 'Children':
      case 'Electorates':
      case 'Positions':
      case 'Regions':
        view = new Fractions.Views.NestedIndex({
          model: this.model,
          collection: this.model[event.target.innerHTML.toLowerCase()](),
        });
        break;
    }
    this.subviews('.tab-content').forEach(function (subview) {
      subview.remove();
    });
    this.addSubview('.tab-content', view);
  },
});
