ctx = window.applicationContext

class ctx.WadByteData
  LITTLE_ENDIAN = true
  BIG_ENDIAN = false

  constructor: (@data) ->
    @dataView = new DataView(@data)
    @lengthInBytes = @data.byteLength
    @offsetInBytes = 0

  getInt8: (position) ->
    @dataView.getInt8(@offsetInBytes + position)
  getUInt8: (position) ->
    @dataView.getUint8(@offsetInBytes + position)
  getInt16: (position) ->
    @dataView.getInt16(@offsetInBytes + position, LITTLE_ENDIAN)
  getUInt16: (position) ->
    @dataView.getUint16(@offsetInBytes + position, LITTLE_ENDIAN)
  getInt32: (position) ->
    @dataView.getInt32(@offsetInBytes + position, LITTLE_ENDIAN)
  getUInt32: (position) ->
    @dataView.getUint32(@offsetInBytes + position, LITTLE_ENDIAN)

  getString: (offset, length) ->
    intValues = []
    for i in [0..length-1]
      @offsetInBytes += offset
      val = @getUInt8(@offsetInBytes + i)
      if val == 0
        break
      intValues.push(val)
    String.fromCharCodes(intValues).toUpperCase()

