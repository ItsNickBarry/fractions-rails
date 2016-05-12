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
    Fractions.session.fetch({
      success: function (model, response, options) {
        // start Backbone only after fetching
        new Fractions.Routers.Router({ $pagesEl: $('#main') });
        Backbone.history.start();
      }
    });
  }
};

$(document).ready(function(){
  Fractions.initialize();
});
