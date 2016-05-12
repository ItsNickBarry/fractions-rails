Backbone.ShallowNestedModel = Backbone.Model.extend({
  url: function() {
    var modelUrl = _.result(this, 'urlRoot');
    var collectionUrl = _.result(this.collection, 'url');
    if (this.isNew()) {
      return collectionUrl || modelUrl || urlError();
    } else {
      var base = modelUrl || collectionUrl || urlError();
      var id = this.get(this.idAttribute);
      return base.replace(/[^\/]$/, '$&/') + encodeURIComponent(id);
    }
  }
});
