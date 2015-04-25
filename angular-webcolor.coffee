module= angular.module 'webcolor',[]
module.constant 'webcolors',["aliceblue","antiquewhite","aqua","aquamarine","azure","beige","bisque","black","blanchedalmond","blue","blueviolet","brown","burlywood","cadetblue","chartreuse","chocolate","coral","cornflowerblue","cornsilk","crimson","cyan","darkblue","darkcyan","darkgoldenrod","darkgray","darkgreen","darkkhaki","darkmagenta","darkolivegreen","darkorange","darkorchid","darkred","darksalmon","darkseagreen","darkslateblue","darkslategray","darkturquoise","darkviolet","deeppink","deepskyblue","dimgray","dodgerblue","firebrick","floralwhite","forestgreen","fuchsia","gainsboro","ghostwhite","gold","goldenrod","gray","green","greenyellow","honeydew","hotpink","indianred","indigo","ivory","khaki","lavender","lavenderblush","lawngreen","lemonchiffon","lightblue","lightcoral","lightcyan","lightgoldenrodyellow","lightgreen","lightgrey","lightpink","lightsalmon","lightseagreen","lightskyblue","lightslategray","lightsteelblue","lightyellow","lime","limegreen","linen","magenta","maroon","mediumaquamarine","mediumblue","mediumorchid","mediumpurple","mediumseagreen","mediumslateblue","mediumspringgreen","mediumturquoise","mediumvioletred","midnightblue","mintcream","mistyrose","moccasin","navajowhite","navy","oldlace","olive","olivedrab","orange","orangered","orchid","palegoldenrod","palegreen","paleturquoise","palevioletred","papayawhip","peachpuff","peru","pink","plum","powderblue","purple","red","rosybrown","royalblue","saddlebrown","salmon","sandybrown","seagreen","seashell","sienna","silver","skyblue","slateblue","slategray","snow","springgreen","steelblue","tan","teal","thistle","tomato","turquoise","violet","wheat","white","whitesmoke","yellow","yellowgreen"]
module.constant '$webcolor',
  delay: 100
  opacity: .5
  
  zIndex: 1000
  lines: 1

  begin: 0
  endIncrement: 2
  endTranslucent: 0.0125

module.provider '$webcolorLoadingBar',($webcolor)->
  progresses= []

  $get:(webcolors)->
    start: ->
      progress.stop() for progress in progresses if progresses.length

      progresses= []
      for i in [0...$webcolor.lines]
        progress= new Progress webcolors,
          i: i
          delay: $webcolor.delay
          zIndex: $webcolor.zIndex
          opacity: $webcolor.opacity
          begin: Math.random()*$webcolor.begin
          endIncrement: $webcolor.endIncrement
          endTranslucent: $webcolor.endTranslucent
        progresses.push progress

    complete: ->
      progress.hurry() for progress in progresses

class Progress
  constructor: (@colors,@options)->
    @i= 0
    @delay= @options.delay
    @opacity= @options.opacity

    @canvas= document.createElement 'canvas'
    @canvas.className= 'webcolor'
    @canvas.width= window.innerWidth
    @canvas.height= Math.ceil(window.innerHeight / 100)

    @x= 0
    @y= @canvas.height*@options.i

    @context= @canvas.getContext '2d'

    setTimeout =>
      @next()
    ,@options.begin

  # public

  hurry: ->
    @delay= 0
  next: ->
    return if @stopped

    fullfilled= innerWidth < (@i*@canvas.height)

    if fullfilled
      return @stop() if @opacity<=0
      @opacity-= @options.endTranslucent if @delay is 0

    else
      @nextPixel()
      @nextPixel() for i in [1..@options.endIncrement] if @delay is 0
    
    @updateStyle()

    setTimeout =>
      requestAnimationFrame =>
        @next()
    ,@delay
  stop: ->
    @stopped= yes
    @canvas.parentNode.removeChild @canvas if @canvas?.parentNode?

  # private

  getStyle: ->
    opacity= @opacity
    opacity= 0 if @opacity< 0
    [
      "z-index:#{parseInt(@options.zIndex)}"
      "opacity:#{opacity}"
      "position:fixed"
      "left:#{@x}px"
      "top:#{@y}px"
    ].join(';')
  updateStyle: (parentNode='html')->
    parentNode= document.querySelector parentNode
    parentNode.appendChild @canvas if parentNode isnt @canvas.parentNode

    @canvas.setAttribute 'style',@getStyle() if @canvas.getAttribute('style') isnt @getStyle() 
  nextPixel: ->
    contextX= @i++*@canvas.height
    @context.fillStyle= @colors[~~(@colors.length*Math.random())]
    @context.fillRect contextX,0,@canvas.height,@canvas.height
