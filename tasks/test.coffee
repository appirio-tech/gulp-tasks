module.exports = (gulp, $, configs) ->
  runTest = (singleRun = true, coverage = true) ->
    preprocessors                      = {}
    preprocessors[configs.coffeeFiles] = if coverage then 'coverage' else 'coffee'
    preprocessors[configs.specFiles]   = 'coffee'

    options =
      configFile      : configs.karmaConfig
      singleRun       : singleRun
      preprocessors   : preprocessors
      files           : configs.karmaFiles
      coverageReporter: configs.coverageReporter

    $.karma.start options

  gulp.task 'test', ['constants', 'fixtures'], ->
    runTest()

  gulp.task 'test-server', ['constants', 'fixtures'], ->
    runTest false, false
