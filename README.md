# Usage [![Bower version][bower-image]][bower] [![Build Status][travis-image]][travis]
[DEMO](http://jsrun.it/59naga/angular-webcolor)

## for Bower
```bash
$ bower i angular angular-webcolor
```

```html
<head>
<script src="bower_components/angular/angular.min.js"></script>
<script src="bower_components/angular-webcolor/angular-webcolor.js"></script>
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

[bower-image]: https://badge.fury.io/bo/angular-webcolor.svg
[bower]: http://badge.fury.io/bo/angular-webcolor
[travis-image]: https://travis-ci.org/59naga/angular-webcolor.svg?branch=master
[travis]: https://travis-ci.org/59naga/angular-webcolor