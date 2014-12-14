// Generated by CoffeeScript 1.8.0
(function() {
  var WAD_PATH, ctx, httpGet, loadEnd, updateProgress;

  ctx = window.applicationContext;

  WAD_PATH = 'resources/doom.wad';

  ctx.loadFile = function() {
    return httpGet(WAD_PATH);
  };

  httpGet = function(url) {
    var xmlHttp;
    xmlHttp = new XMLHttpRequest();
    xmlHttp.open("GET", url, true);
    xmlHttp.responseType = 'arraybuffer';
    xmlHttp.addEventListener("progress", updateProgress, false);
    xmlHttp.addEventListener("loadend", loadEnd, false);
    return xmlHttp.send();
  };

  updateProgress = function() {
    return ctx.printToConsoleNoNewLine('.');
  };

  loadEnd = function() {
    var arrayBuffer, wad;
    arrayBuffer = this.response;
    if (arrayBuffer) {
      wad = new ctx.Wad;
      return wad.read(arrayBuffer);
    }
  };

}).call(this);

//# sourceMappingURL=wadloader.js.map
