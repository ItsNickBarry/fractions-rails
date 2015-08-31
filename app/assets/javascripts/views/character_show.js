Fractions.Views.CharacterShow = Backbone.CompositeView.extend({
  template: JST['character_show'],
  className: 'fractions-object-element fractions-object-show fractions-object-character',

  events: {

  },

  initialize: function () {
    this.fractions = this.model.fractions();
    this.foundedFractions = this.model.foundedFractions();
    this.user = this.model.user();
    // TODO listen to sync on this.user?
    // this.listenTo(this.user, 'sync', this.render);

    this.listenTo(this.model, 'sync', this.render);
    // TODO separate add/remove, probably won't need this here anyway
    this.listenTo(this.fractions, 'add remove', this.addFraction);
    this.listenTo(this.foundedFractions, 'add remove', this.addFoundedFraction);
  },

  render: function () {
    var content = this.template({ character: this.model });
    this.$el.html(content);
    // this.renderFractionsNew();
    this.renderFractions();
    this.renderFoundedFractionsNew();
    this.renderFoundedFractions();
    return this;
  },

  // renderFractionsNew: function () {
  //   var view = new Fractions.Views.FractionsNew({ collection: this.fractions, founder: this.model });
  //   this.addSubview('#fractions-new', view);
  // },

  renderFractions: function () {
    this.fractions.each(this.addFraction.bind(this));
  },

  addFraction: function (fraction) {
    var view = new Fractions.Views.ListItem({ model: fraction });
    this.addSubview('#fractions-list', view);
  },

  renderFoundedFractionsNew: function () {
    var view = new Fractions.Views.FractionsNew({ collection: this.foundedFractions, founder: this.model });
    this.addSubview('#founded-fractions-new', view);
  },

  renderFoundedFractions: function () {
    this.foundedFractions.each(this.addFoundedFraction.bind(this));
  },

  addFoundedFraction: function (foundedFraction) {
    var view = new Fractions.Views.ListItem({ model: foundedFraction });
    this.addSubview('#founded-fractions-list', view);
  },
});
