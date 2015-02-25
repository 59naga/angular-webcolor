# Usage

## for Browser
```html
<head>
<script src="bower_components/angular/angular.min.js"></script>
<script src="bower_components/angular-webcolor/angular-webcolor.min.js"></script>
<script>
  angular
  .module('myApp',['webcolor'])
  .controller('myController',function($scope,$webcolorLoadingBar,$timeout){
    $scope.message= 'loading...'

    $webcolorLoadingBar.start();
    $timeout(function(){
      $webcolorLoadingBar.complete();
      $scope.message= ''
    },1000);
  });
</script>
</head>
<body ng-app="myApp">
  <div ng-controller="myController">{{message}}</div>
</body>
```

## for NW.js
```coffee
NWGUI= window.require 'nw.gui'
nwwin= NWGUI.Window.get()

webcolor= require 'angular-webcolor'
webcolor nwwin.window
```

# API
## webcolors
is angular.constant Array the **[140 webcolor names](http://www.w3schools.com/html/html_colornames.asp)**.

example:
```js
app.config(function(webcolors){
  console.log(webcolors.join(',')); // aliceblue,antiquewhite,aqua...
})
```
## $webcolorLoadingBar
Respected by [Angular Loading Bar](http://chieffancypants.github.io/angular-loading-bar/).
### $webcolorLoadingBar.start()
Append `<canvas>` to document.body
### $webcolorLoadingBar.complete()
Fast forward animation, After Remove `<canvas>` by document.body

# License
MIT by @59naga
