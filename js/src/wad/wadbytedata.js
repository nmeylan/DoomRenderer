// Generated by CoffeeScript 1.8.0
(function() {
  var ctx;

  ctx = window.applicationContext;

  ctx.WadByteData = (function() {
    var BIG_ENDIAN, LITTLE_ENDIAN;

    LITTLE_ENDIAN = true;

    BIG_ENDIAN = false;

    function WadByteData(data) {
      this.data = data;
      this.dataView = new DataView(this.data);
      this.lengthInBytes = this.data.byteLength;
      this.offsetInBytes = 0;
    }

    WadByteData.prototype.getInt8 = function(offset) {
      return this.dataView.getInt8(this.offsetInBytes + offset);
    };

    WadByteData.prototype.getUInt8 = function(offset) {
      return this.dataView.getUint8(this.offsetInBytes + offset);
    };

    WadByteData.prototype.getInt16 = function(offset) {
      return this.dataView.getInt16(this.offsetInBytes + offset, LITTLE_ENDIAN);
    };

    WadByteData.prototype.getUInt16 = function(offset) {
      return this.dataView.getUint16(this.offsetInBytes + offset, LITTLE_ENDIAN);
    };

    WadByteData.prototype.getInt32 = function(offset) {
      return this.dataView.getInt32(this.offsetInBytes + offset, LITTLE_ENDIAN);
    };

    WadByteData.prototype.getUInt32 = function(offset) {
      return this.dataView.getUint32(this.offsetInBytes + offset, LITTLE_ENDIAN);
    };

    WadByteData.prototype.getString = function(offset, length) {
      var i, intValues, val, _i, _ref;
      intValues = [];
      for (i = _i = 0, _ref = length - 1; 0 <= _ref ? _i <= _ref : _i >= _ref; i = 0 <= _ref ? ++_i : --_i) {
        val = this.getUInt8(this.offsetInBytes + offset + i);
        if (val === 0) {
          break;
        }
        intValues.push(val);
      }
      return String.fromCharCodes(intValues).toUpperCase();
    };

    return WadByteData;

  })();

}).call(this);

//# sourceMappingURL=wadbytedata.js.map
