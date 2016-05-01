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
