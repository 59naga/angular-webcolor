module= angular.module 'webcolor',[]
module.constant 'webcolors',["aliceblue","antiquewhite","aqua","aquamarine","azure","beige","bisque","black","blanchedalmond","blue","blueviolet","brown","burlywood","cadetblue","chartreuse","chocolate","coral","cornflowerblue","cornsilk","crimson","cyan","darkblue","darkcyan","darkgoldenrod","darkgray","darkgreen","darkkhaki","darkmagenta","darkolivegreen","darkorange","darkorchid","darkred","darksalmon","darkseagreen","darkslateblue","darkslategray","darkturquoise","darkviolet","deeppink","deepskyblue","dimgray","dodgerblue","firebrick","floralwhite","forestgreen","fuchsia","gainsboro","ghostwhite","gold","goldenrod","gray","green","greenyellow","honeydew","hotpink","indianred","indigo","ivory","khaki","lavender","lavenderblush","lawngreen","lemonchiffon","lightblue","lightcoral","lightcyan","lightgoldenrodyellow","lightgreen","lightgrey","lightpink","lightsalmon","lightseagreen","lightskyblue","lightslategray","lightsteelblue","lightyellow","lime","limegreen","linen","magenta","maroon","mediumaquamarine","mediumblue","mediumorchid","mediumpurple","mediumseagreen","mediumslateblue","mediumspringgreen","mediumturquoise","mediumvioletred","midnightblue","mintcream","mistyrose","moccasin","navajowhite","navy","oldlace","olive","olivedrab","orange","orangered","orchid","palegoldenrod","palegreen","paleturquoise","palevioletred","papayawhip","peachpuff","peru","pink","plum","powderblue","purple","red","rosybrown","royalblue","saddlebrown","salmon","sandybrown","seagreen","seashell","sienna","silver","skyblue","slateblue","slategray","snow","springgreen","steelblue","tan","teal","thistle","tomato","turquoise","violet","wheat","white","whitesmoke","yellow","yellowgreen"]
module.factory '$webcolor',(webcolors)->
  getRandom: -> webcolors[~~(webcolors.length*Math.random())]
module.provider '$webcolorLoadingBar',->
  progress= null

  $get:(webcolors)->
    start: ->
      progress.stop() if progress?
      progress= new Progress webcolors

    complete: ->
      progress.hurry()

class Progress
  constructor: (@colors)->
    @i= 0
    @delay= 100
    @opacity= 1

    @canvas= document.createElement 'canvas'
    @canvas.className= 'webcolor'
    @canvas.width= window.innerWidth
    @canvas.height= window.innerWidth / 100

    @context= @canvas.getContext '2d'

    @next()

  # public

  hurry: ->
    @delay= 0
  next: ->
    return if @stopped

    fullfilled= innerWidth < (@i*@canvas.height)

    if fullfilled
      return @stop() if @opacity<=0
      @opacity-= 0.025 if @delay is 0

    else
      @nextPixel @i++
      @nextPixel @i++ if @delay is 0
      @nextPixel @i++ if @delay is 0
    
    @updateStyle()

    requestAnimationFrame =>
      setTimeout (=>@next()),@delay
  stop: ->
    @stopped= yes
    @canvas.parentNode.removeChild @canvas if @canvas?.parentNode?

  # private

  getStyle: ->
    opacity= @opacity
    opacity= 0 if @opacity< 0
    [
      "opacity:#{opacity}"
      'position:absolute'
      'top:0'
      'left:0'
      'right:0'
      'bottom:0'
    ].join(';')
  updateStyle: ->
    @canvas.setAttribute 'style',@getStyle() if @canvas.getAttribute('style') isnt @getStyle() 
  nextPixel: ->
    contextX= @i*@canvas.height
    @context.fillStyle= @colors[~~(@colors.length*Math.random())]
    @context.fillRect contextX,0,@canvas.height,@canvas.height

    bodies= document.querySelectorAll 'body'
    bodies[0].appendChild @canvas if bodies[0] isnt @canvas.parentNode
