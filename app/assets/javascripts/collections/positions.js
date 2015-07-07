Fractions.Collections.Positions = Backbone.Collection.extend({
  model: Fractions.Models.Position,
  url: 'api/positions',

  getOrFetch: function (id) {
    var positions = this;

    var position;
    if (position = this.get(id)) {
      position.fetch();
    } else {
      position = new Fractions.Models.Position({ id: id });
      position.fetch({
        success: function () { positions.add(position); }
      });
    }

    return position;
  }
});
