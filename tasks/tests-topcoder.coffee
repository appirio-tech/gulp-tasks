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

  # Add vet to this task once files are cleaned up a bit
  gulp.task 'test:topcoder', ['template-cache', 'ng-constant'], (done) ->
    startTests true, done

  # Add vet to this task once files are cleaned up a bit
  gulp.task 'autotest:topcoder', ['template-cache', 'ng-constant'], (done) ->
    startTests false, done
