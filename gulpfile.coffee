'use strict'

configs =
  __dirname: __dirname

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
