'use strict'

path        = require 'path'
fs          = require 'fs'
nodeEnvFile = require 'node-env-file'

getVal = (name, defaultVal) ->
  hasOwnProperty = process.env.hasOwnProperty name

  return process.env[name].trim() if hasOwnProperty

  return defaultVal if defaultVal

  null

readFile = (file) ->
  existsSync = fs.existsSync file

  nodeEnvFile file if existsSync

module.exports =
  getVal  : getVal
  readFile: readFile

