window.applicationContext = {
  consoleText: null
  consoleHolder: null
  canvas: null
  screenWidth: window.innerWidth
  screenHeight: window.innerHeight
  gl: null
  crashed: false
  gameVisible: true
}

ctx = window.applicationContext

requirejs.config(
  baseUrl: 'js/src'
  paths:
    dom: 'dom'
    util: 'util'
    wad: 'wad'
)
require(['dom/element',
         'util/console',
         'util/string',
         'wad/wadbytedata',
         'wad/wad',
         'wad/wadloader'
  ], (element) ->
  startup = ->
    ctx.consoleText = document.querySelector('#consoleText')
    ctx.consoleHolder = document.querySelector('#consoleHolder')
    ctx.printToConsole('startup')

    ctx.canvas = document.querySelector("#game");
    ctx.canvas.setAttribute("width", "#{ctx.screenWidth}px");
    ctx.canvas.setAttribute("height", "#{ctx.screenHeight}px");
    ctx.printToConsole('set up canvas')

    initializeWebGl(ctx.canvas)
    ctx.printToConsole('WebGL context has been initialized')
    initializeShaders
    ctx.printToConsole('Loading WAD')
    ctx.loadFile()


  initializeWebGl = (canvas) ->
    gl = canvas.getContext("webgl")
    unless gl
      crash('Webgl context has not been initialized', null)
      return


  initializeShaders = ->
    fragmentShader = getShader(ctx.gl, "shader-fs")
    vertexShader = getShader(ctx.gl, "shader-vs")
    # Create the shader program
    shaderProgram = ctx.gl.createProgram()
    ctx.gl.attachShader(shaderProgram, vertexShader)
    ctx.gl.attachShader(shaderProgram, fragmentShader)
    ctx.gl.linkProgram(shaderProgram)
    # If creating the shader program failed, alert
    unless ctx.gl.getProgramParameter(shaderProgram, ctx.gl.LINK_STATUS)
      crash("Unable to initialize the shader program.")
    ctx.gl.useProgram(shaderProgram);
    vertexPositionAttribute = ctx.gl.getAttribLocation(shaderProgram,
      "aVertexPosition")
    ctx.gl.enableVertexAttribArray(vertexPositionAttribute)


  crash = (title, payload, stackTrace = null) ->
    if (ctx.crashed)
      throw payload
    try
      ctx.canvas.setAttribute("style", "display:none;")
      ctx.gameVisible = false
      document.exitPointerLock()
      document.querySelector("#consoleHolder").setAttribute("style", "")
    catch e

    ctx.crashed = true;
    ctx.printToConsole("");
    ctx.printToConsole("");
    ctx.printToConsole("-------------------------------------------------");
    ctx.printToConsole("                      CRASH                      ");
    ctx.printToConsole("-------------------------------------------------");
    ctx.printToConsole(title);
    ctx.printToConsole("");
    ctx.printToConsole("#{payload}");
    if stackTrace != null
      printToConsole("")
      printToConsole("Stack trace:")
      printToConsole("#{stackTrace}")


  startup()
)

