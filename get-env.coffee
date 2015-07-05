'use strict'

path       = require 'path'
fs         = require 'fs'
env        = require './node_modules/node-env-file'
envFile    = path.join __dirname, '../.env'
existsSync = fs.existsSync envFile

if existsSync
  envFile
  env()

getVal = (name, defaultVal) ->
  hasOwnProperty = process.env.hasOwnProperty name

  return process.env[name].trim() if hasOwnProperty

  return defaultVal if defaultVal

  null

module.exports =
  getVal: getVal
