module.exports = (gulp, $, configs) ->
  runTest = (singleRun = true, coverage = true) ->
    preprocessors = {}
    preprocessors[configs.karma.appFiles]  = if coverage then 'coverage' else 'coffee'
    preprocessors[configs.karma.specFiles] = 'coffee'

    files = configs.karma.dependencies.concat configs.karma.appFiles
    files = files.concat configs.karma.specFiles

    options =
      configFile      : configs.karma.configFile
      singleRun       : singleRun
      preprocessors   : preprocessors
      files           : files
      coverageReporter: configs.coverageReporter

    $.karma.start options

  gulp.task 'test', ['ng-constant', 'fixtures'], ->
    runTest()

  gulp.task 'test-server', ['ng-constant', 'fixtures'], ->
    runTest false, false
