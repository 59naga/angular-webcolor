# ![angular-webcolor][.svg] Angular-webcolor [![Bower version][bower-image]][bower] [![Build Status][travis-image]][travis]

[![Join the chat at https://gitter.im/59naga/angular-webcolor](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/59naga/angular-webcolor?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

* [DEMO](http://jsrun.it/59naga/angular-webcolor)
* [DEMO2](http://jsrun.it/59naga/yHIb)

## Installation
```bash
$ bower install angular angular-ui-router angular-webcolor
```

```html
<html ng-app="myApp">
  <head>
  <script src="bower_components/angular/angular.min.js"></script>
  <script src="bower_components/angular-ui-router/release/angular-ui-router.min.js"></script>
  <script src="bower_components/angular-webcolor/public/angular-webcolor.min.js"></script>
  <script>
    angular
    .module('myApp',['ui.router','webcolor'])
    .config(function($stateProvider){
      $stateProvider.state('second',{
        url:'second',
        template:'{{message}} <br><a ui-sref="first">first</a>',
        controller:function($scope){
          $scope.message= 'this is second'
        },
      });
      $stateProvider.state('first',{
        url:'*path',
        resolve:{
          delay:function($timeout){
            return $timeout(function(){return 0},1000)
          },
        },
        template:'{{message}} <br><a ui-sref="second">second</a>',
        controller:function($scope,delay){
          $scope.message= 'this is first'
        },
      });
    })
    .run(function($rootScope,$webcolorLoadingBar){
      $rootScope.$on('$stateChangeStart',function(){
        $webcolorLoadingBar.start();
      });
      $rootScope.$on('$stateChangeSuccess',function(){
        $webcolorLoadingBar.complete();
      });
    });
  </script>
  </head>
  <body ui-view>loading...</body>  
</html>
```

# API
## webcolors
is angular.constant Array the **[140 webcolor names](http://www.w3schools.com/html/html_colornames.asp)**.

example:
```js
app.config(function(webcolors){
  console.log(webcolors); // Array[140] "aliceblue","antiquewhite","aqua","...""
})
```
## $webcolorLoadingBar
### .start()
Begin render.
### .complete()
Fast forward render.

### Change $webcolorLoadingBar behavior
```js
angular
.module('myApp',['ui.router','webcolor'])
.config(function($webcolor){
  $webcolor.delay= 50;// default 100
  $webcolor.opacity= 1;// default .5

  $webcolor.zIndex= 50;// default 1000
  $webcolor.lines= 100;// default 1

  $webcolor.begin= 1000;// default 0
  $webcolor.endIncrement= 3;// default 2
  $webcolor.endTranslucent= 0.02;// default 0.0125
})
```
### $webcolor.delay
(msec) Rendering speed of 1 pixel.

### $webcolor.opacity
(0~1) Set the initial opacity.

### $webcolor.zIndex
(0~) Set css z-index property for $webcolorLoadingBar.

### $webcolor.lines
(0~100) Number of $webcolorLoadingBar

### $webcolor.begin
(msec) Set the maximum randam delay for begin render.

### $webcolor.endIncrement
(int) Rendering number of pixel for delay. after $webcolorLoadingBar.complete();
### $webcolor.endTranslucent
(float) Set transclunet per frame. after rendered.

# License
[MIT][License] by @59naga

[License]: http://59naga.mit-license.org/

[.svg]: https://cdn.rawgit.com/59naga/angular-webcolor/master/.svg?

[bower-image]: https://badge.fury.io/bo/angular-webcolor.svg
[bower]: http://badge.fury.io/bo/angular-webcolor
[travis-image]: https://travis-ci.org/59naga/angular-webcolor.svg?branch=master
[travis]: https://travis-ci.org/59naga/angular-webcolor
