ctx = window.applicationContext

class ctx.WadByteData
  LITTLE_ENDIAN = true
  BIG_ENDIAN = false

  constructor: (@data) ->
    @dataView = new DataView(@data)
    @lengthInBytes = @data.byteLength
    @offsetInBytes = 0

  view: (offset, length)->
    @offsetInBytes = offset
    @lengthInBytes = ((length == null) ? @lengthInBytes - offset : length)

  getInt8: (offset) ->
    @dataView.getInt8(@offsetInBytes + offset)
  getUInt8: (offset) ->
    @dataView.getUint8(@offsetInBytes + offset)
  getInt16: (offset) ->
    @dataView.getInt16(@offsetInBytes + offset, LITTLE_ENDIAN)
  getUInt16: (offset) ->
    @dataView.getUint16(@offsetInBytes + offset, LITTLE_ENDIAN)
  getInt32: (offset) ->
    @dataView.getInt32(@offsetInBytes + offset, LITTLE_ENDIAN)
  getUInt32: (offset) ->
    @dataView.getUint32(@offsetInBytes + offset, LITTLE_ENDIAN)

  getString: (offset, length) ->
    intValues = []
    for i in [0..length-1]
      val = @getUInt8(offset + i)
      if val == 0
        break
      intValues.push(val)
    String.fromCharCodes(intValues).toUpperCase()