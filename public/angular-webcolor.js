(function() {
  var Progress, module;

  module = angular.module('webcolor', []);

  module.constant('webcolors', ["aliceblue", "antiquewhite", "aqua", "aquamarine", "azure", "beige", "bisque", "black", "blanchedalmond", "blue", "blueviolet", "brown", "burlywood", "cadetblue", "chartreuse", "chocolate", "coral", "cornflowerblue", "cornsilk", "crimson", "cyan", "darkblue", "darkcyan", "darkgoldenrod", "darkgray", "darkgreen", "darkkhaki", "darkmagenta", "darkolivegreen", "darkorange", "darkorchid", "darkred", "darksalmon", "darkseagreen", "darkslateblue", "darkslategray", "darkturquoise", "darkviolet", "deeppink", "deepskyblue", "dimgray", "dodgerblue", "firebrick", "floralwhite", "forestgreen", "fuchsia", "gainsboro", "ghostwhite", "gold", "goldenrod", "gray", "green", "greenyellow", "honeydew", "hotpink", "indianred", "indigo", "ivory", "khaki", "lavender", "lavenderblush", "lawngreen", "lemonchiffon", "lightblue", "lightcoral", "lightcyan", "lightgoldenrodyellow", "lightgreen", "lightgrey", "lightpink", "lightsalmon", "lightseagreen", "lightskyblue", "lightslategray", "lightsteelblue", "lightyellow", "lime", "limegreen", "linen", "magenta", "maroon", "mediumaquamarine", "mediumblue", "mediumorchid", "mediumpurple", "mediumseagreen", "mediumslateblue", "mediumspringgreen", "mediumturquoise", "mediumvioletred", "midnightblue", "mintcream", "mistyrose", "moccasin", "navajowhite", "navy", "oldlace", "olive", "olivedrab", "orange", "orangered", "orchid", "palegoldenrod", "palegreen", "paleturquoise", "palevioletred", "papayawhip", "peachpuff", "peru", "pink", "plum", "powderblue", "purple", "red", "rosybrown", "royalblue", "saddlebrown", "salmon", "sandybrown", "seagreen", "seashell", "sienna", "silver", "skyblue", "slateblue", "slategray", "snow", "springgreen", "steelblue", "tan", "teal", "thistle", "tomato", "turquoise", "violet", "wheat", "white", "whitesmoke", "yellow", "yellowgreen"]);

  module.constant('$webcolor', {
    delay: 100,
    opacity: .5,
    zIndex: 1000,
    lines: 1,
    begin: 0,
    endIncrement: 2,
    endTranslucent: 0.0125
  });

  module.provider('$webcolorLoadingBar', ["$webcolor", function($webcolor) {
    var progresses;
    progresses = [];
    return {
      $get: ["webcolors", function(webcolors) {
        return {
          start: function() {
            var i, j, k, len, progress, ref, results;
            if (progresses.length) {
              for (j = 0, len = progresses.length; j < len; j++) {
                progress = progresses[j];
                progress.stop();
              }
            }
            progresses = [];
            results = [];
            for (i = k = 0, ref = $webcolor.lines; 0 <= ref ? k < ref : k > ref; i = 0 <= ref ? ++k : --k) {
              progress = new Progress(webcolors, {
                i: i,
                delay: $webcolor.delay,
                zIndex: $webcolor.zIndex,
                opacity: $webcolor.opacity,
                begin: Math.random() * $webcolor.begin,
                endIncrement: $webcolor.endIncrement,
                endTranslucent: $webcolor.endTranslucent
              });
              results.push(progresses.push(progress));
            }
            return results;
          },
          complete: function() {
            var j, len, progress, results;
            results = [];
            for (j = 0, len = progresses.length; j < len; j++) {
              progress = progresses[j];
              results.push(progress.hurry());
            }
            return results;
          }
        };
      }]
    };
  }]);

  Progress = (function() {
    function Progress(colors, options) {
      this.colors = colors;
      this.options = options;
      this.i = 0;
      this.delay = this.options.delay;
      this.opacity = this.options.opacity;
      this.canvas = document.createElement('canvas');
      this.canvas.className = 'webcolor';
      this.canvas.width = window.innerWidth;
      this.canvas.height = Math.ceil(window.innerHeight / 100);
      this.x = 0;
      this.y = this.canvas.height * this.options.i;
      this.context = this.canvas.getContext('2d');
      setTimeout((function(_this) {
        return function() {
          return _this.next();
        };
      })(this), this.options.begin);
    }

    Progress.prototype.hurry = function() {
      return this.delay = 0;
    };

    Progress.prototype.next = function() {
      var fullfilled, i, j, ref;
      if (this.stopped) {
        return;
      }
      fullfilled = innerWidth < (this.i * this.canvas.height);
      if (fullfilled) {
        if (this.opacity <= 0) {
          return this.stop();
        }
        if (this.delay === 0) {
          this.opacity -= this.options.endTranslucent;
        }
      } else {
        this.nextPixel();
        if (this.delay === 0) {
          for (i = j = 1, ref = this.options.endIncrement; 1 <= ref ? j <= ref : j >= ref; i = 1 <= ref ? ++j : --j) {
            this.nextPixel();
          }
        }
      }
      this.updateStyle();
      return setTimeout((function(_this) {
        return function() {
          return requestAnimationFrame(function() {
            return _this.next();
          });
        };
      })(this), this.delay);
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
      if (this.opacity < 0) {
        opacity = 0;
      }
      return ["z-index:" + (parseInt(this.options.zIndex)), "opacity:" + opacity, "position:fixed", "left:" + this.x + "px", "top:" + this.y + "px"].join(';');
    };

    Progress.prototype.updateStyle = function(parentNode) {
      if (parentNode == null) {
        parentNode = 'html';
      }
      parentNode = document.querySelector(parentNode);
      if (parentNode !== this.canvas.parentNode) {
        parentNode.appendChild(this.canvas);
      }
      if (this.canvas.getAttribute('style') !== this.getStyle()) {
        return this.canvas.setAttribute('style', this.getStyle());
      }
    };

    Progress.prototype.nextPixel = function() {
      var contextX;
      contextX = this.i++ * this.canvas.height;
      this.context.fillStyle = this.colors[~~(this.colors.length * Math.random())];
      return this.context.fillRect(contextX, 0, this.canvas.height, this.canvas.height);
    };

    return Progress;

  })();

}).call(this);
