ctx = window.applicationContext

class ctx.Wad
  DIRECTORY_LUMP_ENTRY_SIZE =16
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

  constructor: ->
    @header = {}
    @lumpHash = {}
    @data = null

  read: (data) ->
    @data = new ctx.WadByteData(data)
    @readHeader()

  readHeader: () ->
    @header.identification = @data.getString(0, 4)
    if @header.identification != 'IWAD'
      throw 'This not a IWAD format'
    @header.numberLumps = @data.getUInt32(0x04)
    @header.lumpInfoTableOffset = @data.getUInt32(0x08)

    if @header.lumpInfoTableOffset + @header.numberLumps * DIRECTORY_LUMP_ENTRY_SIZE > @data.lengthInBytes
      throw "Can't contains all lump table"
    @collectLumpInfo()


  collectLumpInfo: ->
    console.log('fdp');
    for i in[0..@header.numberLumps] by 1
      offset = @header.lumpInfoTableOffset + i * DIRECTORY_LUMP_ENTRY_SIZE
      position = @data.getUInt32(offset + 0x00)
      size = @data.getUInt32(offset + 0x04)
      name = @data.getString(offset + 0x08, 8)
      lumpInfo = new LumpInfo(name, position, size)
      @lumpHash[name] = lumpInfo
      



class LumpInfo
  constructor: (@name, @position, @size) ->