window.applicationContext = {
  consoleText: null
  consoleHolder: null
  content: null
  canvas: null
  screenWidth: window.innerWidth
  screenHeight: window.innerHeight
  gl: null
  crashed: false
  gameVisible: true
}

ctx = window.applicationContext

requirejs.config(
  baseUrl: '../js/src'
  paths:
    dom: 'dom'
    util: 'util'
    wad: 'wad'
)

require(['dom/element',
        'util/console',
        'util/String',
         'wad/wadbytedata',
         'wad/wad',
         'wad/wadloader'
  ], (element) ->
  startup = ->
    ctx.consoleText = document.querySelector('#consoleText')
    ctx.consoleHolder = document.querySelector('#consoleHolder')
    ctx.content = document.querySelector('#content')
    ctx.printToConsole('Read playpal')
    ctx.loadFile('../resources/doom.wad', callback)

  callback = ->
    arrayBuffer = this.response
    if arrayBuffer
      wad = new ctx.Wad
      wad.read(arrayBuffer)
      wad.readPlaypal()
      i = 0
      for palette in wad.playpal.palettes
        ctx.content.appendHtml("<div class='palette' id='palette-"+i+"'></div>")
        for color in [0..255] by 1
          document.querySelector('#palette-'+i).appendHtml("<span class='color' style='background-color: rgb("+palette.r[color]+","+palette.g[color]+","+palette.b[color]+")'></span>")
        i++




  startup()
)