exec = require('child_process').exec

execute = (command, callback) ->
  exec command, (error, stdout, stderr)
     -> callback(stdout)

execute("ls -la", console.log)

