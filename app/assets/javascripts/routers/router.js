Fractions.Routers.Router = Backbone.Router.extend({
  routes: {
    '': 'root',
    'map': 'mapShow',
    'characters/:id': 'characterShow',
    'electorates/:id': 'electorateShow',
    'fractions/:id/electorates': 'fractionElectoratesIndex',
    'fractions/:id/positions': 'fractionPositionsIndex',
    'fractions/:id/regions': 'fractionRegionsIndex',
    'fractions/:id/children': 'fractionChildrenIndex',
    'fractions/:id/founded_fractions': 'fractionFoundedFractionsIndex',
    'fractions/:id': 'fractionShow',
    'positions/:id': 'positionShow',
    'regions/:id': 'regionShow',
    // 'plots/:id': 'plotShow'
    'users/:id': 'userShow',
  },

  initialize: function (options) {
    this.$pagesEl = options.$pagesEl;
  },

  root: function () {
    var view = new Fractions.Views.Root();
    this.swapView(view);
  },

  mapShow: function () {
    // TODO pass objects into Map view?
    var view = new Fractions.Views.MapShow();
    this.swapView(view);
  },

  userShow: function (id) {
    var model = new Fractions.Models.User({ id: id });
    model.fetch({
      success: function () {
        var view = new Fractions.Views.UserShow({ model: model });
        this.swapView(view);
      }.bind(this)
    });
  },

  characterShow: function (id) {
    var model = new Fractions.Models.Character({ id: id });
    model.fetch({
      success: function () {
        var view = new Fractions.Views.CharacterShow({ model: model });
        this.swapView(view);
      }.bind(this)
    });
  },

  electorateShow: function (id) {
    var model = new Fractions.Models.Electorate({ id: id });
    model.fetch({
      success: function () {
        var view = new Fractions.Views.ElectorateShow({ model: model });
        this.swapView(view);
      }.bind(this)
    });
  },

  fractionShow: function (id) {
    var model = new Fractions.Models.Fraction({ id: id });
    model.fetch({
      success: function () {
        var view = new Fractions.Views.FractionShow({ model: model });
        this.swapView(view);
      }.bind(this)
    });
  },

  fractionElectoratesIndex: function (id) {
    this.fractionNestedIndex(id, 'electorates');
  },

  fractionPositionsIndex: function (id) {
    this.fractionNestedIndex(id, 'positions');
  },

  fractionRegionsIndex: function (id) {
    this.fractionNestedIndex(id, 'regions');
  },

  fractionChildrenIndex: function (id) {
    this.fractionNestedIndex(id, 'children');
  },

  fractionFoundedFractionsIndex: function (id) {
    this.fractionNestedIndex(id, 'founded fractions', 'fraction');
  },

  fractionNestedIndex: function (id, name, noun) {
    var model = new Fractions.Models.Fraction({ id: id });
    model.fetch({
      success: function () {
        var view = new Fractions.Views.NestedIndex({ model: model, name: name, noun: noun });
        this.swapView(view);
      }.bind(this)
    });
  },

  positionShow: function (id) {
    var model = new Fractions.Models.Position({ id: id });
    model.fetch({
      success: function () {
        var view = new Fractions.Views.PositionShow({ model: model });
        this.swapView(view);
      }.bind(this)
    });
  },

  regionShow: function (id) {
    var model = new Fractions.Models.Region({ id: id });
    model.fetch({
      success: function () {
        var view = new Fractions.Views.RegionShow({ model: model });
        this.swapView(view);
      }.bind(this)
    });
  },

  swapView: function (view) {
    this._currentView && this._currentView.remove();
    this._currentView = view;
    this.$pagesEl.html(view.render().$el);
  }
});
