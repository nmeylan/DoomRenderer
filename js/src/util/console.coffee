ctx = window.applicationContext

ctx.printToConsole = (text) ->
  ctx.consoleText.appendHtml("\r" + text)
  ctx.consoleHolder.scrollTop = ctx.consoleHolder.scrollHeight

ctx.printToConsoleNoNewLine = (text) ->
  ctx.consoleText.appendHtml(" " + text)
  ctx.consoleHolder.scrollTop = ctx.consoleHolder.scrollHeight