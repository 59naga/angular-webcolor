express= require 'express'
app= express()
app.use express.static require('path').resolve __dirname
app.listen 59798

return if not describe?

describe 'gulp-webcolor',->
  canvas= element By.tagName 'canvas'

  beforeEach ->
    browser.get '/public/'
    browser.waitForAngular()

  it 'Launched express',->
    expect(browser.getTitle()).toEqual 'super loading bar'
    expect(canvas.getAttribute 'class').toEqual 'webcolor'

  it 'Remove canvas for reload',->
    expect(canvas.getAttribute 'class').toEqual 'webcolor'

    before= null
    canvas.getRawId()
    .then (beforeId)->
      before= beforeId
      
      browser.get '/public/'
    .then ->
      canvas.getRawId()
    .then (afterId)->
      expect(before).not.toEqual afterId