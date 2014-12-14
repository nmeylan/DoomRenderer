String.fromCharCodes = (array) ->
  str = ''
  for code in array
    str += String.fromCharCode(code)
  str