path = require 'path'

module.exports = (gulp, $, configs) ->
  startTests = (singleRun, done) ->
    karma = require('karma').server
    excludeFiles = []
    serverSpecs = configs.karma?.serverIntegrationSpecs || []

    excludeFiles = serverSpecs;

    karmaCompleted = (karmaResult) ->
      console.log 'Karma completed!'
      if karmaResult == 1
        done 'karma: tests failed with code ' + karmaResult
      else
        done()

    karmaOptions =
      configFile: path.join configs.__dirname,'/karma.conf.js'
      exclude   : excludeFiles
      singleRun : !!singleRun

    karma.start karmaOptions, karmaCompleted

  gulp.task 'test-tc', ['template-cache', 'ng-constant'], (done) ->
    runTest true, done

  gulp.task 'autotest-tc', ['vet', 'template-cache', 'ng-constant'], (done) ->
    runTest false, done
