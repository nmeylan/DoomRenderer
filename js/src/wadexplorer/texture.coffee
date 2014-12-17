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
    ctx.printToConsole('Read texture')
    ctx.loadFile('../resources/doom.wad', callback)

  callback = ->
    arrayBuffer = this.response
    if arrayBuffer
      wad = new ctx.Wad
      wad.read(arrayBuffer)
      wad.readTextures()
      ctx.content.appendHtml("<ul id='textures'></ul>")
      for name, texture of wad.textures
        li = "<li><a href='#'>"+name+"</a></li>"
        document.querySelector('#textures').appendHtml(li)






  startup()
)