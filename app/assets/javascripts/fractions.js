// use Underscore.string as Underscore plugin
_.mixin(s.exports());

Backbone.Collection = Backbone.Collection.extend({
  getOrFetch: function (id) {
    var collection = this;
    var model;
    if (model = this.get(id)) {
      model.fetch();
    } else {
      model = new collection.model({ id: id });
      model.fetch({
        success: function () { collection.add(model); }
      });
    }
    return model;
  }
});

window.Fractions = {
  D3Views: {},
  Concerns: {},
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
    Fractions.session = new Fractions.Models.Session();
    new Fractions.Views.SessionView({ model: Fractions.session });
    Fractions.session.fetch({
      success: function (model, response, options) {
        new Fractions.Routers.Router({ $pagesEl: $('#main') });
        Backbone.history.start();
      },
    });
  }
};

Fractions.authorizeeSearch = function (event) {
  Fractions.search(
    event,
    ['Electorate', 'Position']
  );
},

Fractions.nameSearch = function (event) {
  Fractions.search(
    event,
    ['Character', 'Electorate', 'Fraction', 'Position', 'Region', 'User']
  );
},

Fractions.search = function (event, classes) {
  // autocomplete is reinitialized whenever field is focused, causing cache
  // to be cleared; cache is therefore only used when backspacing
  $(event.target).autocomplete({
    serviceUrl: '/api/search',
    dataType: 'json',
    groupBy: 'category',
    minChars: 3,
    params: {
      classes: classes,
    },
    onSelect: function (suggestion) {
      window.location = '/#/' + suggestion.data.category + '/' + suggestion.data.id
    },
  });
};

$(document).ready(function(){
  Fractions.initialize();
});
