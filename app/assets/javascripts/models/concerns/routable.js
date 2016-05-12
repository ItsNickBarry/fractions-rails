Fractions.Concerns.Routable = {
  urlFragment: function () {
    return this.urlFragmentRoot
    ?
      '#' + this.urlFragmentRoot + '/' + this.get('id')
    :
      'javascript:void(0)'
    ;
  },
};
