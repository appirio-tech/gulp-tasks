'use strict'

defaultTasks = [
  'coffee'
  'jade'
  'fonts'
  'images'
  'linters'
  'scss'
  'clean'
  'inject'
  'optimize'
  'serve'
  'build'
  'test'
  'tests-topcoder'
  'ng-constant'
  'coveralls'
  'fixtures'
  'template-cache'
  'uglify'
  'minify-css'
  'cdnify'
  'finger-print'
  'finger-print-replace'
  'useref'
  'remove-code'
  'copy-files'
  'deploy'
  'e2e'
  'bower-images'
  'styleguide-generator'
]

gulp            = require 'gulp'
gulpLoadPlugins = require 'gulp-load-plugins'
browserSync     = require 'browser-sync'
karma           = require 'karma'

loadTasks = (configs = {}, tasks = null) ->
  basePath                   = configs.__dirname || __dirname
  nodePath                   = basePath + '/node_modules'
  tasks                      = tasks || defaultTasks
  configs.karma              = configs.karma || {}
  configs.e2eTest            = configs.e2eTest || {}
  configs.karma.configFile   = basePath + '/karma.conf.coffee'
  configs.e2eTest.configFile = basePath + '/protractor.config.js'

  if basePath.includes 'gulp-tasks'
    gulpTasksPath = basePath
  else
    gulpTasksPath = basePath + '/node_modules/appirio-gulp-tasks'

  $ = gulpLoadPlugins
    config: gulpTasksPath + '/package.json'

  $.browserSync = browserSync
  $.karma       = karma.server

  configs.env   = require './get-env.coffee'
  envFile       = configs.envFile || '.env'

  configs.env.readFile envFile

  for task in tasks
    module = require gulpTasksPath + '/tasks/' + task
    module gulp, $, configs

module.exports =
  loadTasks: loadTasks
