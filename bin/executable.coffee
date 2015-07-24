#! /usr/bin/env coffee

myModule = require '../lib/main.js'
port = parseInt process.argv[2]

myModule.serverStart port
