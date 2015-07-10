Fractions.Routers.Router = Backbone.Router.extend({
  routes: {
    '': 'root',
    'map': 'map',
    'characters/:id': 'characterShow',
    'electorates/:id': 'electorateShow',
    'fractions/:id': 'fractionShow',
    'positions/:id': 'positionShow',
    'regions/:id': 'regionShow',
    // 'plots/:id': 'plotShow'
    'users/:id': 'userShow',
  },

  initialize: function ($rootEl) {
    this.$rootEl = $rootEl;
  },

  root: function () {
    var view = new Fractions.Views.Root();
    this.swapView(view);
  },

  map: function () {
    // TODO pass objects into Map view?
    // perhaps pass in a Map object?
    var view = new Fractions.Views.Map();
    this.swapView(view);
  },

  userShow: function (id) {
    var user = new Fractions.Models.User({ id: id });
    user.fetch();
    var view = new Fractions.Views.UserShow({ model: user });
    this.swapView(view);
  },

  characterShow: function (id) {
    var character = new Fractions.Models.Character({ id: id });
    character.fetch();
    var view = new Fractions.Views.CharacterShow({ model: character });
    this.swapView(view);
  },

  electorateShow: function (id) {
    var electorate = new Fractions.Models.Electorate({ id: id });
    electorate.fetch();
    var view = new Fractions.Views.ElectorateShow({ model: electorate });
    this.swapView(view);
  },

  fractionShow: function (id) {
    var fraction = new Fractions.Models.Fraction({ id: id });
    fraction.fetch();
    var view = new Fractions.Views.FractionShow({ model: fraction });
    this.swapView(view);
  },

  positionShow: function (id) {
    var position = new Fractions.Models.Position({ id: id });
    position.fetch();
    var view = new Fractions.Views.PositionShow({ model: position });
    this.swapView(view);
  },

  swapView: function (view) {
    this._currentView && this._currentView.remove();
    this._currentView = view;
    this.$rootEl.html(view.render().$el);
  }
});
