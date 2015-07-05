Fractions.Routers.Router = Backbone.Router.extend({
  routes: {
    '': 'root',
    'users/:id': 'userShow',
    'characters/:id': 'characterShow',
  },

  initialize: function ($rootEl) {
    this.$rootEl = $rootEl;
  },

  root: function () {
    var view = new Fractions.Views.Root();
    this.swapView(view);
  },

  userShow: function (id) {
    var user = new Fractions.Models.User({ id: id });
    user.fetch();
    var view = new Fractions.Views.UserShow({ model: user });
    this.swapView(view);
  },

  swapView: function (view) {
    this._currentView && this._currentView.remove();
    this._currentView = view;
    this.$rootEl.html(view.render().$el);
  }
});
