(function(f){if(typeof exports==="object"&&typeof module!=="undefined"){module.exports=f()}else if(typeof define==="function"&&define.amd){define([],f)}else{var g;if(typeof window!=="undefined"){g=window}else if(typeof global!=="undefined"){g=global}else if(typeof self!=="undefined"){g=self}else{g=this}g.window = f()}})(function(){var define,module,exports;return (function e(t,n,r){function s(o,u){if(!n[o]){if(!t[o]){var a=typeof require=="function"&&require;if(!u&&a)return a(o,!0);if(i)return i(o,!0);var f=new Error("Cannot find module '"+o+"'");throw f.code="MODULE_NOT_FOUND",f}var l=n[o]={exports:{}};t[o][0].call(l.exports,function(e){var n=t[o][1][e];return s(n?n:e)},l,l.exports,e,t,n,r)}return n[o].exports}var i=typeof require=="function"&&require;for(var o=0;o<r.length;o++)s(r[o]);return s})({1:[function(require,module,exports){
var angularWebcolor;

angularWebcolor = function(window) {
  var angular, document, module;
  document = window.document;
  angular = window.angular;
  module = angular.module('webcolor', []);
  module.constant('webcolors', ["aliceblue", "antiquewhite", "aqua", "aquamarine", "azure", "beige", "bisque", "black", "blanchedalmond", "blue", "blueviolet", "brown", "burlywood", "cadetblue", "chartreuse", "chocolate", "coral", "cornflowerblue", "cornsilk", "crimson", "cyan", "darkblue", "darkcyan", "darkgoldenrod", "darkgray", "darkgreen", "darkkhaki", "darkmagenta", "darkolivegreen", "darkorange", "darkorchid", "darkred", "darksalmon", "darkseagreen", "darkslateblue", "darkslategray", "darkturquoise", "darkviolet", "deeppink", "deepskyblue", "dimgray", "dodgerblue", "firebrick", "floralwhite", "forestgreen", "fuchsia", "gainsboro", "ghostwhite", "gold", "goldenrod", "gray", "green", "greenyellow", "honeydew", "hotpink", "indianred", "indigo", "ivory", "khaki", "lavender", "lavenderblush", "lawngreen", "lemonchiffon", "lightblue", "lightcoral", "lightcyan", "lightgoldenrodyellow", "lightgreen", "lightgrey", "lightpink", "lightsalmon", "lightseagreen", "lightskyblue", "lightslategray", "lightsteelblue", "lightyellow", "lime", "limegreen", "linen", "magenta", "maroon", "mediumaquamarine", "mediumblue", "mediumorchid", "mediumpurple", "mediumseagreen", "mediumslateblue", "mediumspringgreen", "mediumturquoise", "mediumvioletred", "midnightblue", "mintcream", "mistyrose", "moccasin", "navajowhite", "navy", "oldlace", "olive", "olivedrab", "orange", "orangered", "orchid", "palegoldenrod", "palegreen", "paleturquoise", "palevioletred", "papayawhip", "peachpuff", "peru", "pink", "plum", "powderblue", "purple", "red", "rosybrown", "royalblue", "saddlebrown", "salmon", "sandybrown", "seagreen", "seashell", "sienna", "silver", "skyblue", "slateblue", "slategray", "snow", "springgreen", "steelblue", "tan", "teal", "thistle", "tomato", "turquoise", "violet", "wheat", "white", "whitesmoke", "yellow", "yellowgreen"]);
  module.factory('$webcolor', function(webcolors) {
    return {
      getRandom: function() {
        return webcolors[~~(webcolors.length * Math.random())];
      }
    };
  });
  return module.provider('$webcolorLoadingBar', function() {
    var busy, canvas, context, delay, i, opacity, style;
    i = 0;
    delay = 0;
    opacity = 1;
    style = function() {
      return ["opacity:" + opacity, 'position:absolute', 'top:0', 'left:0', 'right:0', 'bottom:0'].join(';');
    };
    canvas = null;
    context = null;
    busy = null;
    return {
      $get: function($webcolor) {
        var nextPixel;
        nextPixel = function(i) {
          var bodies, contextX;
          contextX = i * canvas.height;
          context.fillStyle = $webcolor.getRandom();
          context.fillRect(contextX, 0, canvas.height, canvas.height);
          if (canvas.getAttribute('style') !== style()) {
            canvas.setAttribute('style', style());
          }
          bodies = document.querySelectorAll('body');
          if (bodies[0] !== canvas.parentNode) {
            return bodies[0].appendChild(canvas);
          }
        };
        return {
          start: function() {
            if (busy != null) {
              return;
            }
            busy = true;
            i = 0;
            delay = 100;
            opacity = 1;
            canvas = document.createElement('canvas');
            canvas.className = 'webcolor';
            canvas.width = window.innerWidth;
            canvas.height = window.innerWidth / 100;
            context = canvas.getContext('2d');
            window.requestAnimationFrame(function() {
              return canvas.progress();
            });
            return canvas.progress = (function(_this) {
              return function() {
                if (notcanvas.parentNode != null) {
                  return;
                }
                nextPixel(i++);
                if (delay === 0) {
                  nextPixel(i++);
                }
                if (delay === 0) {
                  nextPixel(i++);
                }
                if (window.innerWidth < (i * canvas.height)) {
                  if (delay === 0) {
                    opacity -= 0.025;
                  }
                  if (opacity <= 0) {
                    canvas.parentNode.removeChild(canvas);
                    busy = null;
                    return;
                  }
                }
                return window.requestAnimationFrame(function() {
                  return window.setTimeout(function() {
                    return canvas.progress();
                  }, delay);
                });
              };
            })(this);
          },
          complete: function() {
            return delay = 0;
          }
        };
      }
    };
  });
};

if (typeof (typeof window !== "undefined" && window !== null ? window.angular : void 0) === 'object') {
  angularWebcolor(window);
}

if (typeof module !== "undefined" && module !== null) {
  module.exports = angularWebcolor;
}



},{}]},{},[1])(1)
});