NWGUI= window.require 'nw.gui'
nwwin= NWGUI.Window.get()
nwwin.on 'document-end',->
  window= nwwin.window

  nwwin.resizeTo 300,100
  padding= 100
  x= window.screen.width-nwwin.width - padding
  y= padding #window.screen.height-nwwin.height
  nwwin.moveTo x,y
  
  angularColor= require '../angular-webcolor'
  angularColor window
  
  window.setTimeout ->
    angular= window.angular
    
    main= angular.module 'main',['webcolor']
    main.run ($webcolorLoadingBar)->
      $webcolorLoadingBar.start()
      setTimeout (-> $webcolorLoadingBar.complete()),1000

    angular.bootstrap window.document,['main']
