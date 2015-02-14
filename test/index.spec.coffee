NWGUI= window.require 'nw.gui'

jasmine.DEFAULT_TIMEOUT_INTERVAL= 5000

describe 'index',->
  window= null
  document= null
  canvas= null

  it 'Create canvas element and Remove',(done)->
    window.addEventListener 'message',(event)->
      if event.data is '$webcolorLoadingBar:start'
        {width}= document.querySelector 'canvas'
        expect(width).toEqual(window.document.body.clientWidth)

      if event.data is '$webcolorLoadingBar:finish'
        canvas= document.querySelector 'canvas'
        expect(canvas).toEqual(null)
        done()

  beforeEach (nwwinDOMContentLoaded)->
    nwwin= NWGUI.Window.get()
    nwwin.reload()
    nwwin.on 'loaded',->
      nwwin= NWGUI.Window.get()
      window= nwwin.window
      document= window.document
      canvas= document.querySelector 'canvas'

      nwwinDOMContentLoaded()
