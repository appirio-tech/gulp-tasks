'use strict'

defaultTasks = [
  'coffee'
  'jade'
  'scss'
  'clean'
  'serve'
  'build'
  'test'
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
  'aws-publish'
  'e2e'
  'bower-images'
  'styleguide-generator'
]

fileExists = require 'file-exists'

loadTasks = (configs = {}, tasks = null) ->
  defaultTaskPath            = configs.__dirname + '/node_modules/appirio-gulp-tasks'
  defaultTaskPath            = null unless fileExists defaultTaskPath
  taskPath                   = configs.taskPath || defaultTaskPath || __dirname
  tasks                      = tasks || defaultTasks
  configs.karma              = configs.karma || {}
  configs.e2eTest            = configs.e2eTest || {}
  configs.karma.configFile   = taskPath + '/karma.conf.coffee'
  configs.e2eTest.configFile = taskPath + '/protractor.config.js'
  pluginsPath                = taskPath + '/node_modules/gulp-load-plugins'
  browserSyncPath            = taskPath + '/node_modules/browser-sync'
  karmaPath                  = taskPath + '/node_modules/karma'
  configPath                 = taskPath + '/node_modules/config'

  gulpLoadPluginsOptions =
    config: taskPath + '/package.json'

  gulp           = require 'gulp'
  plugins        = require pluginsPath
  $              = plugins gulpLoadPluginsOptions
  $.browserSync  = require browserSyncPath
  $.karma        = require(karmaPath).server
  configs.env    = require './get-env.coffee'
  envFile        = configs.envFile || '.env'

  configs.env.readFile envFile

  for task in tasks
    module = require(taskPath + '/tasks/' + task)
    module gulp, $, configs

  # gulp.task 'default', ['clean'], ->
  #   gulp.start 'build'

module.exports =
  loadTasks: loadTasks
