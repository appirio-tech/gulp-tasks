'use strict'

configs = {}

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
