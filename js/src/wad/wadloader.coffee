ctx = window.applicationContext
WAD_PATH = 'resources/doom.wad'

ctx.loadFile = (url, callack) ->
  httpGet(url || WAD_PATH, callack)

httpGet = (url, callack) ->
  xmlHttp = new XMLHttpRequest()
  xmlHttp.open("GET", url, true)
  xmlHttp.responseType = 'arraybuffer'
  xmlHttp.addEventListener("progress", updateProgress, false);
  xmlHttp.addEventListener("loadend", callack || loadEnd, false);
  xmlHttp.send();

updateProgress = ->
  ctx.printToConsoleNoNewLine('.')

loadEnd =  ->
  arrayBuffer = this.response
  if arrayBuffer
    wad = new ctx.Wad
    wad.read(arrayBuffer)