Fractions.Models.Founder = Backbone.Model.extend(
  Fractions.Concerns.Routable
).extend({
  urlFragmentRoot: function () {
    return '/' + _.pluralize(this.escape('class').toLowerCase());
  },
});
