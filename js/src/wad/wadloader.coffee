ctx = window.applicationContext
WAD_PATH = 'resources/doom.wad'

ctx.loadFile = ->
  httpGet(WAD_PATH)

httpGet = (url) ->
  xmlHttp = new XMLHttpRequest()
  xmlHttp.open("GET", url, true)
  xmlHttp.responseType = 'arraybuffer'
  xmlHttp.addEventListener("progress", updateProgress, false);
  xmlHttp.addEventListener("loadend", loadEnd, false);
  xmlHttp.send();

updateProgress = ->
  ctx.printToConsoleNoNewLine('.')

loadEnd = ->
  arrayBuffer = this.response
  if arrayBuffer
    wad = new ctx.Wad
    wad.read(arrayBuffer)
