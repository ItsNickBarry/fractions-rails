Fractions.Collections.Fractions = Backbone.Collection.extend({
  model: Fractions.Models.Fraction,
  url: 'api/fractions',

  getOrFetch: function (id) {
    var fractions = this;

    var fraction;
    if (fraction = this.get(id)) {
      fraction.fetch();
    } else {
      fraction = new Fractions.Models.Fraction({ id: id });
      fraction.fetch({
        success: function () { fractions.add(fraction); }
      });
    }

    return fraction;
  }
});
