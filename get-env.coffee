'use strict'

path        = require 'path'
fs          = require 'fs'
nodeEnvFile = require './node_modules/node-env-file'

getVal = (name, defaultVal) ->
  hasOwnProperty = process.env.hasOwnProperty name

  return process.env[name].trim() if hasOwnProperty

  return defaultVal if defaultVal

  null

readFile = (file) ->
  envFile    = path.join __dirname, file
  existsSync = fs.existsSync envFile

  nodeEnvFile envFile if existsSync

module.exports =
  getVal  : getVal
  readFile: readFile

