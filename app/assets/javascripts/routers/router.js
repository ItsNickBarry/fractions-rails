Fractions.Routers.Router = Backbone.Router.extend({
  routes: {
    '':                             'root',
    'map':                          'mapShow',
    ':object/:id':                  'modelShow',
    ':table/:id/administration':    'authorizerAdministration',
    'fractions/:id/:nested_index':  'fractionCollectionIndex',
  },

  initialize: function (options) {
    this.$pagesEl = options.$pagesEl;
  },

  root: function () {
    var view = new Fractions.Views.Root();
    this.swapView(view);
  },

  modelShow: function (object, id) {
    var className = _.capitalize(_.camelize(_.singularize(object)));
    var model = new Fractions.Models[className]({ id: id });
    model.fetch({
      success: function () {
        var view = new Fractions.Views[className + 'Show']({ model: model });
        this.swapView(view);
      }.bind(this),
    });
  },

  mapShow: function () {
    // TODO pass objects into Map view?
    var view = new Fractions.Views.MapShow();
    this.swapView(view);
  },

  authorizerAdministration: function (table, id) {
    debugger
    var model = new Fractions.Models[_.singularize(_.camelize(_.titleize(table.toLowerCase())))]({
      id: id
    });
    model.fetch({
      success: function () {
        var view = new Fractions.Views.GovernmentAuthorizationIndex({
          model: model,
        });
        this.swapView(view);
      }.bind(this),
    });
  },

  fractionCollectionIndex: function (id, nested_index) {
    var model = new Fractions.Models.Fraction({ id: id });
    model.fetch({
      success: function () {
        var view = new Fractions.Views.NestedIndex({
          model: model,
          collection: model[_.camelize(nested_index)](),
        });
        this.swapView(view);
      }.bind(this),
    });
  },

  swapView: function (view) {
    this._currentView && this._currentView.remove();
    this._currentView = view;
    this.$pagesEl.html(view.render().$el);
  },
});
