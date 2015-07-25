http       = require 'http'
express    = require 'express'
bodyParser = require 'body-parser'
exec       = require('child_process').exec
fs         = require 'fs'

# jekyll local server address and port
jekyll_host = 'http://localhost:4000'

app = express()
app.use bodyParser.json()
app.use bodyParser.urlencoded({extended: true})
app.use (req, res, next) ->
  # to allow cross origin access
  res.setHeader 'Access-Control-Allow-Origin', jekyll_host
  res.setHeader 'Access-Control-Allow-Methods', 'POST'
  res.setHeader 'Access-Control-Allow-Headers', 'X-Requested-With,content-type'
  res.setHeader 'Access-Control-Allow-Credentials', true
  next()
server = http.createServer app


chromeToEmacs = (lineno, mdfilepath) ->
  command  = "/usr/local/Cellar/emacs/24.3/bin/emacsclient --no-wait +#{lineno} \"#{mdfilepath}\""
  exec command, (err, out, outerr) -> console.log out


app.post '/', (req, res) ->
  console.log "coming post data : #{JSON.stringify req.body}"
  switch req.body.sender
    when 'chrome' then chromeToEmacs req.body.lineno, req.body.path
    when 'emacs'  then 'nothing happens'
  obj =
    status: 'success'
    data: req.body
  res.send JSON.stringify(obj)


module.exports.serverStart = (port) ->
  server.listen port
  console.log "I'm waiting a request at localhost:#{port}/"  
