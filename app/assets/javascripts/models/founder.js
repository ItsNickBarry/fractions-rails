Fractions.Models.Founder = Backbone.Model.extend({
  urlFragment: function () {
    return '#/' + this.escape('class').toLowerCase() + 's/' + this.get('id');
  }
});
