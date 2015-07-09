Fractions.Collections.Electorates = Backbone.Collection.extend({
  model: Fractions.Models.Electorate,
  url: 'api/electorates',

  getOrFetch: function (id) {
    var electorates = this;

    var electorate;
    if (electorate = this.get(id)) {
      electorate.fetch();
    } else {
      electorate = new Fractions.Models.Electorate({ id: id });
      electorate.fetch({
        success: function () { electorates.add(electorate); }
      });
    }

    return electorate;
  }
});
