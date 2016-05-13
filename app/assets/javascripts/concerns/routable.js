Fractions.Concerns.Routable = {
  a: function (text) {
    return'<a href=' + this.urlFragment() + '>' + text +'</a>';
  },

  urlFragment: function () {
    if (this instanceof Backbone.Model) {
      return this._modelUrlFragment();
    } else if (this instanceof Backbone.Collection) {
      return this._collectionUrlFragment();
    }
  },

  _collectionUrlFragment: function () {
    // TODO generalized url fragment for nested/non-nested collection
    return this.parentModel.urlFragment() + '/' + _.underscored(this.name);
  },

  _modelUrlFragment: function () {
    return this.urlFragmentRoot
    ?
      '#' + _.result(this, 'urlFragmentRoot') + '/' + this.get('id')
    :
      'javascript:void(0)'
    ;
  },
};
