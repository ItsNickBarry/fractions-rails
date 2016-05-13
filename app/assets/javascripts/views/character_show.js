Fractions.Views.CharacterShow = Backbone.CompositeView.extend({
  template: JST['character_show'],

  initialize: function () {
    this.fractions = this.model.fractions();
    this.foundedFractions = this.model.foundedFractions();
    this.user = this.model.user();

    this.listenTo(this.model, 'sync', this.render);

    this.addSubviewForFractions();
    this.addSubviewForFoundedFractions();
    this.addSubviewForFoundedFractionsNew();
  },

  render: function () {
    var content = this.template({ character: this.model });
    this.$el.html(content);
    this.attachSubviews();
    return this;
  },

  addSubviewForFractions: function () {
    var view = new Fractions.Views.List({
      collection: this.fractions
    });
    this.addSubview('#fractions-list', view);
  },

  addSubviewForFoundedFractions: function () {
    var view = new Fractions.Views.List({
      collection: this.foundedFractions
    });
    this.addSubview('#founded-fractions-list', view);
  },

  addSubviewForFoundedFractionsNew: function () {
    var view = new Fractions.Views.FractionsNew({
      collection: this.foundedFractions
    });
    this.addSubview('#founded-fractions-new', view);
  },
});
