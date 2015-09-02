window.Fractions = {
  D3Views: {},
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
    // TODO keep track of currentUser/session, fetch at appropriate time
    Fractions.session = new Fractions.Models.Session();
    Fractions.session.fetch({
      success: function (model, response, options) {
        new Fractions.Routers.Router({ $pagesEl: $('#main') });
        Backbone.history.start();
      }
    });
  }
};

$(document).ready(function(){
  Fractions.initialize();
});
