module.exports = (gulp, $, configs) ->
  runTest = (singleRun = true, coverage = true) ->
    preprocessors = {}
    preprocessors[configs.karma.coverage]  = if coverage then 'coverage' else 'coffee'

    for coffeeFile in configs.karma.coffeeFiles
      preprocessors[coffeeFile] = 'coffee'

    options =
      basePath        : configs.karma.basePath
      configFile      : configs.karma.configFile
      singleRun       : singleRun
      preprocessors   : preprocessors
      files           : configs.karma.files
      coverageReporter: configs.coverageReporter

    $.karma.start options

  dependencies = ['ng-constant', 'fixtures', 'template-cache']

  gulp.task 'test', dependencies, ->
    runTest()

  gulp.task 'test-serve', dependencies, ->
    runTest false, false
