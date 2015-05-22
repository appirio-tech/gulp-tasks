module.exports = (gulp, $, configs) ->
  runTest = (singleRun = true, coverage = true) ->
    preprocessors = {}
    preprocessors[configs.karma.coverage]  = if coverage then 'coverage' else 'coffee'

    for coffeeFile in configs.karma.coffeeFiles
      preprocessors[coffeeFile] = 'coffee'

    options =
      configFile      : configs.karma.configFile
      singleRun       : singleRun
      preprocessors   : preprocessors
      files           : configs.karma.files
      coverageReporter: configs.coverageReporter

    $.karma.start options

  gulp.task 'test', ['ng-constant', 'fixtures'], ->
    runTest()

  gulp.task 'test-server', ['ng-constant', 'fixtures'], ->
    runTest false, false
