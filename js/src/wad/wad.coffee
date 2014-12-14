ctx = window.applicationContext

class ctx.Wad
  @lumpNames = [
    "THINGS",
    "LINEDEFS",
    "SIDEDEFS",
    "VERTEXES",
    "SEGS",
    "SSECTORS",
    "NODES",
    "SECTORS",
    "REJECT",
    "BLOCKMAP",
    "GENMIDI",
    "DMXGUS",
    "PLAYPAL",
    "COLORMAP",
    "ENDOOM",
    "TEXTURE1",
    "TEXTURE2",
    "PNAMES"
  ]
  constructor: ->
    @header = {}

  read: (data) ->
    @data = new ctx.WadByteData(data)
    @readHeader()

  readHeader: () ->
    @header.identification = @data.getString(0, 4)
    ctx.printToConsole(@header.identification)
    @header.numberLumps = @data.getUInt32(0x04)
    ctx.printToConsole(@header.numberLumps)
    ctx.printToConsole(@data.offsetInBytes)

