'use strict'

defaultTaskPath = '.'
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
]

loadTasks = (configs = null, tasks = null) ->
  taskPath                 = configs.taskPath || '.'
  tasks                    = tasks || defaultTasks
  configs.karma.configFile = __dirname + '/' + taskPath + '/karma.conf.coffee'
  configs.karma.basePath   = __dirname
  pluginsPath              = taskPath + '/node_modules/gulp-load-plugins'
  browserSyncPath          = taskPath + '/node_modules/browser-sync'
  karmaPath                = taskPath + '/node_modules/karma'
  configPath               = taskPath + '/node_modules/config'

  gulpLoadPluginsOptions =
    config: __dirname + '/' + taskPath + '/package.json'

  gulp           = require 'gulp'
  plugins        = require pluginsPath
  $              = plugins gulpLoadPluginsOptions
  $.browserSync  = require browserSyncPath
  $.karma        = require(karmaPath).server
  configs.env    = require './get-env.coffee'

  for task in tasks
    module = require(taskPath + '/tasks/' + task)
    module gulp, $, configs

  gulp.task 'default', ['clean'], ->
    gulp.start 'build'

module.exports =
  loadTasks: loadTasks
