fs = require 'fs-plus'
path = require 'path'
Record = require './record'

exports.download = (req, res, next) ->
  dist = "pool/files/minidump"
  fileName = req.params.id
  currFile = path.join dist, fileName
  fs.exists currFile, (exist) ->
    if exist?
      uri = encodeURI fileName
      res.set {"Content-type":"application/octet-stream","Content-Disposition":"attachment;filename="+uri}
      fReadStream = fs.createReadStream currFile
      fReadStream.on "data", (chunk)->
        res.write chunk,"binary"
      fReadStream.on "end", ()->
        res.end()
      return
      
    res.set "Content-type", "text/html"
    res.send "file not exist!"
    res.end()
