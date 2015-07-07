'use strict'

configs =
  scssIncludePaths: require('node-neat').includePaths
  tempFolder      : '.tmp'
  appFolder       : 'app'
  distFolder      : 'dist'

configs.karma =
  configFile  : __dirname + '/karma.conf.coffee'
  basePath    : __dirname
  coverage    : 'app/**/*.coffee'
  coffeeFiles : ['tests/specs/**/*.coffee'] # Dont include coverage files
  files: [
    'bower_components/jquery/dist/jquery.js'
    '.tmp/scripts/json-fixtures.js'
    'app/**/*.coffee'
    'tests/specs/**/*.coffee'
  ]

configs.templateCache =
  files : [
    '.tmp/views/footer.html'
    '.tmp/views/main.html'
  ]
  root  : 'views/'
  module: 'appirio-tech-messaging'


### END CONFIG ###

loadTasksModule = require './load-tasks.coffee'

loadTasksModule.loadTasks configs
