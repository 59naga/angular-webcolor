NWGUI= window.require 'nw.gui'
nwwin= NWGUI.Window.get()
nwwin.on 'document-end',->
  window= nwwin.window

  nwwin.resizeTo 300,100
  padding= 100
  x= window.screen.width-nwwin.width - padding
  y= padding #window.screen.height-nwwin.height
  nwwin.moveTo x,y
  
  angularColor= require '../angular-webcolor.min.js'
  angularColor window
  
  window.setTimeout ->
    angular= window.angular
    
    main= angular.module 'main',['webcolor','ui.router']
    main.config ($stateProvider)->
      $stateProvider.state 'duplicated body element',
        url:''
        template:''
        controller:->

    main.run ($webcolorLoadingBar)->
      $webcolorLoadingBar.start()
      setTimeout (-> $webcolorLoadingBar.complete()),2000

    angular.bootstrap window.document,['main']
