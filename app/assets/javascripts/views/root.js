Fractions.Views.Root = Backbone.CompositeView.extend({
  template: JST['root'],
  className: 'fractions-object-element fractions-root',

  render: function () {
    var content = this.template();
    this.$el.html(content);
    return this;
  }
});
