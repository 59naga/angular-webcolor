angularWebcolor= (window)->
  document= window.document
  angular= window.angular
  module= angular.module 'webcolor',[]
  
  module.constant 'webcolors',["aliceblue","antiquewhite","aqua","aquamarine","azure","beige","bisque","black","blanchedalmond","blue","blueviolet","brown","burlywood","cadetblue","chartreuse","chocolate","coral","cornflowerblue","cornsilk","crimson","cyan","darkblue","darkcyan","darkgoldenrod","darkgray","darkgreen","darkkhaki","darkmagenta","darkolivegreen","darkorange","darkorchid","darkred","darksalmon","darkseagreen","darkslateblue","darkslategray","darkturquoise","darkviolet","deeppink","deepskyblue","dimgray","dodgerblue","firebrick","floralwhite","forestgreen","fuchsia","gainsboro","ghostwhite","gold","goldenrod","gray","green","greenyellow","honeydew","hotpink","indianred","indigo","ivory","khaki","lavender","lavenderblush","lawngreen","lemonchiffon","lightblue","lightcoral","lightcyan","lightgoldenrodyellow","lightgreen","lightgrey","lightpink","lightsalmon","lightseagreen","lightskyblue","lightslategray","lightsteelblue","lightyellow","lime","limegreen","linen","magenta","maroon","mediumaquamarine","mediumblue","mediumorchid","mediumpurple","mediumseagreen","mediumslateblue","mediumspringgreen","mediumturquoise","mediumvioletred","midnightblue","mintcream","mistyrose","moccasin","navajowhite","navy","oldlace","olive","olivedrab","orange","orangered","orchid","palegoldenrod","palegreen","paleturquoise","palevioletred","papayawhip","peachpuff","peru","pink","plum","powderblue","purple","red","rosybrown","royalblue","saddlebrown","salmon","sandybrown","seagreen","seashell","sienna","silver","skyblue","slateblue","slategray","snow","springgreen","steelblue","tan","teal","thistle","tomato","turquoise","violet","wheat","white","whitesmoke","yellow","yellowgreen"]
  module.factory '$webcolor',(webcolors)->
    getRandom:-> webcolors[~~(webcolors.length*Math.random())]
  module.provider '$webcolorLoadingBar',->
    i= 0
    delay= 0
    opacity= 1
    style= -> [
      "opacity:#{opacity}"
      'position:absolute'
      'top:0'
      'left:0'
      'right:0'
      'bottom:0'
    ].join(';')
    canvas= null
    context= null
    busy= null

    $get:($webcolor)->
      nextPixel= (i)->
        contextX= i*canvas.height
        context.fillStyle= $webcolor.getRandom()
        context.fillRect contextX,0,canvas.height,canvas.height

        canvas.setAttribute 'style',style() if canvas.getAttribute('style') isnt style() 
        bodies= document.querySelectorAll 'body'
        bodies[0].appendChild canvas if bodies[0] isnt canvas.parentNode

      start:->
        return if busy?
        busy= yes

        i= 0
        delay= 100
        opacity= 1

        canvas= document.createElement 'canvas'
        canvas.className= 'webcolor'
        canvas.width= window.innerWidth
        canvas.height= window.innerWidth / 100

        context= canvas.getContext '2d'

        window.requestAnimationFrame -> canvas.progress()
        canvas.progress= =>
          nextPixel i++
          nextPixel i++ if delay is 0
          nextPixel i++ if delay is 0
          if window.innerWidth < (i*canvas.height)
            opacity-= 0.025 if delay is 0
            if opacity<=0
              canvas.parentNode.removeChild canvas

              busy= null
              return

          window.requestAnimationFrame ->
            window.setTimeout ->
              canvas.progress()
            ,delay

      complete:->
        delay= 0

angularWebcolor window if typeof window?.angular is 'object'
module.exports= angularWebcolor if module?