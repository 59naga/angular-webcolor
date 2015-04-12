(function() {
  var Progress, module;

  module = angular.module('webcolor', []);

  module.constant('webcolors', ["aliceblue", "antiquewhite", "aqua", "aquamarine", "azure", "beige", "bisque", "black", "blanchedalmond", "blue", "blueviolet", "brown", "burlywood", "cadetblue", "chartreuse", "chocolate", "coral", "cornflowerblue", "cornsilk", "crimson", "cyan", "darkblue", "darkcyan", "darkgoldenrod", "darkgray", "darkgreen", "darkkhaki", "darkmagenta", "darkolivegreen", "darkorange", "darkorchid", "darkred", "darksalmon", "darkseagreen", "darkslateblue", "darkslategray", "darkturquoise", "darkviolet", "deeppink", "deepskyblue", "dimgray", "dodgerblue", "firebrick", "floralwhite", "forestgreen", "fuchsia", "gainsboro", "ghostwhite", "gold", "goldenrod", "gray", "green", "greenyellow", "honeydew", "hotpink", "indianred", "indigo", "ivory", "khaki", "lavender", "lavenderblush", "lawngreen", "lemonchiffon", "lightblue", "lightcoral", "lightcyan", "lightgoldenrodyellow", "lightgreen", "lightgrey", "lightpink", "lightsalmon", "lightseagreen", "lightskyblue", "lightslategray", "lightsteelblue", "lightyellow", "lime", "limegreen", "linen", "magenta", "maroon", "mediumaquamarine", "mediumblue", "mediumorchid", "mediumpurple", "mediumseagreen", "mediumslateblue", "mediumspringgreen", "mediumturquoise", "mediumvioletred", "midnightblue", "mintcream", "mistyrose", "moccasin", "navajowhite", "navy", "oldlace", "olive", "olivedrab", "orange", "orangered", "orchid", "palegoldenrod", "palegreen", "paleturquoise", "palevioletred", "papayawhip", "peachpuff", "peru", "pink", "plum", "powderblue", "purple", "red", "rosybrown", "royalblue", "saddlebrown", "salmon", "sandybrown", "seagreen", "seashell", "sienna", "silver", "skyblue", "slateblue", "slategray", "snow", "springgreen", "steelblue", "tan", "teal", "thistle", "tomato", "turquoise", "violet", "wheat", "white", "whitesmoke", "yellow", "yellowgreen"]);

  module.factory('$webcolor', ["webcolors", function(webcolors) {
    return {
      getRandom: function() {
        return webcolors[~~(webcolors.length * Math.random())];
      }
    };
  }]);

  module.provider('$webcolorLoadingBar', function() {
    var progress;
    progress = null;
    return {
      $get: ["webcolors", function(webcolors) {
        return {
          start: function() {
            if (progress != null) {
              progress.stop();
            }
            return progress = new Progress(webcolors);
          },
          complete: function() {
            return progress.hurry();
          }
        };
      }]
    };
  });

  Progress = (function() {
    function Progress(colors) {
      this.colors = colors;
      this.i = 0;
      this.delay = 100;
      this.opacity = 1;
      this.canvas = document.createElement('canvas');
      this.canvas.className = 'webcolor';
      this.canvas.width = window.innerWidth;
      this.canvas.height = window.innerWidth / 100;
      this.context = this.canvas.getContext('2d');
      this.next();
    }

    Progress.prototype.hurry = function() {
      return this.delay = 0;
    };

    Progress.prototype.next = function() {
      var fullfilled;
      if (this.stopped) {
        return;
      }
      fullfilled = innerWidth < (this.i * this.canvas.height);
      if (fullfilled) {
        if (this.opacity <= 0) {
          return this.stop();
        }
        if (this.delay === 0) {
          this.opacity -= 0.025;
        }
      } else {
        this.nextPixel(this.i++);
        if (this.delay === 0) {
          this.nextPixel(this.i++);
        }
        if (this.delay === 0) {
          this.nextPixel(this.i++);
        }
      }
      this.updateStyle();
      return requestAnimationFrame((function(_this) {
        return function() {
          return setTimeout((function() {
            return _this.next();
          }), _this.delay);
        };
      })(this));
    };

    Progress.prototype.stop = function() {
      var ref;
      this.stopped = true;
      if (((ref = this.canvas) != null ? ref.parentNode : void 0) != null) {
        return this.canvas.parentNode.removeChild(this.canvas);
      }
    };

    Progress.prototype.getStyle = function() {
      var opacity;
      opacity = this.opacity;
      return ["opacity:" + opacity, 'position:absolute', 'top:0', 'left:0', 'right:0', 'bottom:0'].join(';');
    };

    Progress.prototype.updateStyle = function() {
      if (this.canvas.getAttribute('style') !== this.getStyle()) {
        return this.canvas.setAttribute('style', this.getStyle());
      }
    };

    Progress.prototype.nextPixel = function() {
      var bodies, contextX;
      contextX = this.i * this.canvas.height;
      this.context.fillStyle = this.colors[~~(this.colors.length * Math.random())];
      this.context.fillRect(contextX, 0, this.canvas.height, this.canvas.height);
      bodies = document.querySelectorAll('body');
      if (bodies[0] !== this.canvas.parentNode) {
        return bodies[0].appendChild(this.canvas);
      }
    };

    return Progress;

  })();

}).call(this);
