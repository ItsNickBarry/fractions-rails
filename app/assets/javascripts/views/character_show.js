Fractions.Views.CharacterShow = Backbone.CompositeView.extend({
  template: JST['character_show'],

  initialize: function () {
    this.fractions = this.model.fractions();
    this.foundedFractions = this.model.foundedFractions();
    this.user = this.model.user();

    this.listenTo(this.model, 'sync', this.render);

    this.addSubview('#fractions-list', new Fractions.Views.List({
      collection: this.fractions,
    }));

    this.addSubview('#founded-fractions-list', new Fractions.Views.List({
      collection: this.foundedFractions,
    }));

    this.addSubview('#founded-fractions-new', new Fractions.Views.AuthorizableForm({
      collection: this.foundedFractions,
      model: this.model,
      subFormTemplate: 'fractions_new'
    }));
  },

  render: function () {
    var content = this.template({
      character: this.model,
    });
    this.$el.html(content);
    this.attachSubviews();
    return this;
  },
});
