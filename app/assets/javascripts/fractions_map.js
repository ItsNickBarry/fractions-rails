;
(function () {
  // TODO put map object definition here
  var Map = Fractions.Map = function (el) {
    // accept a DOM element, rather than try to find it
    // this is (mostly) equivalent to d3.select('#map')
    this.el = el;
  };

  Map.prototype.render = function () {
    // if you copy and paste your code into here, and change the
    // "d3.select('#index')" to "this.el", it will render properly
  };
})();
