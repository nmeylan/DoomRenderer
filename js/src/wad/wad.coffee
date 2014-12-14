ctx = window.applicationContext

DIRECTORY_LUMP_ENTRY_SIZE = 16
NUMBER_PALETTES = 14

LUMP_NAMES = [
  "BLOCKMAP",
  "COLORMAP",
  "DMXGUS",
  "ENDOOM",
  "GENMIDI",
  "LINEDEFS",
  "NODES",
  "PLAYPAL",
  "PNAMES",
  "REJECT",
  "SECTORS",
  "SEGS",
  "SIDEDEFS",
  "SSECTORS",
  "TEXTURE1",
  "TEXTURE2",
  "THINGS",
  "VERTEXES"]

class ctx.Wad
  constructor: ->
    @header = {}
    @lumpHash = {}
    @data = null

  read: (data) ->
    @data = new ctx.WadByteData(data)
    @readHeader()
    @playpall = new Playpal(@lumpHash["PLAYPAL"].getByteData(@data))

  readHeader: () ->
    @header.identification = @data.getString(0, 4)
    if @header.identification != 'IWAD'
      throw 'Only IWAD files are read'
    @header.numberLumps = @data.getUInt32(0x04)
    @header.lumpInfoTableOffset = @data.getUInt32(0x08)

    if @header.lumpInfoTableOffset + @header.numberLumps * DIRECTORY_LUMP_ENTRY_SIZE > @data.lengthInBytes
      throw 'Can\'t contains all lump tables'
    @collectLumpInfo()


  collectLumpInfo: ->
    for i in[0..@header.numberLumps - 1] by 1
      offset = @header.lumpInfoTableOffset + i * DIRECTORY_LUMP_ENTRY_SIZE
      position = @data.getUInt32(offset + 0x00)
      size = @data.getUInt32(offset + 0x04)
      name = @data.getString(offset + 0x08, 8)
      lumpInfo = new LumpInfo(name, position, size)
      @lumpHash[name] = lumpInfo


class Playpal
  constructor: (@data) ->
    @palettes = []
    position = 0
    for i in [0..NUMBER_PALETTES - 1] by 1
      palette = new Palette
      for j in [0..255] by 1
        palette.r[j] = @data.getUInt8(position++)
        palette.g[j] = @data.getUInt8(position++)
        palette.b[j] = @data.getUInt8(position++)
      @palettes.push(palette)

class Palette
  constructor: ->
    @r = new Uint8Array(256)
    @g = new Uint8Array(256)
    @b = new Uint8Array(256)

class LumpInfo
  constructor: (@name, @position, @size) ->

  getByteData: (data) ->
    data.view(@position, @size)
    data