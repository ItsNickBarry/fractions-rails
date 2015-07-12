Fractions.Models.Region = Backbone.Model.extend({
  urlRoot: '/api/regions',

  parse: function (response) {
    if (response.fraction) {
      this.fraction().set(response.fraction, { parse: true });
      delete response.fraction;
    }
    return response;
  },

  fraction: function () {
    if (!this._fraction) {
      this._fraction = new Fractions.Models.Fraction();
    }
    return this._fraction;
  }
});
