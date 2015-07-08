Fractions.Collections.Regions = Backbone.Collection.extend({
  model: Fractions.Models.Region,
  url: 'api/regions',

  getOrFetch: function (id) {
    var regions = this;

    var region;
    if (region = this.get(id)) {
      region.fetch();
    } else {
      region = new Fractions.Models.Region({ id: id });
      region.fetch({
        success: function () { regions.add(region); }
      });
    }

    return region;
  }
});
