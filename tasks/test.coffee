wiredep                 = require 'wiredep'
defualtConfigFile       = '../karma.conf.coffee'
defaultCoverageReporter =
  type: 'lcov'
  dir: 'coverage'

module.exports = (gulp, $, configs) ->
  defaultCoffeeFiles   = [configs.__dirname + '/tests/specs/**/*.coffee'] # Dont include coverage files
  coffeeFiles          = configs.karma?.coffeeFiles || defaultCoffeeFiles
  bowerJSONPath        = configs.__dirname + '/./bower.json'
  defaultCoverageFiles = configs.__dirname + '/app/**/*.coffee'
  configFile           = configs.karma?.configFile || defualtConfigFile
  coverageFiles        = configs.karma?.coverage || defaultCoverageFiles
  bowerJSON            = require bowerJSONPath
  coverageReporter     = configs.coverageReporter || defaultCoverageReporter

  wiredepOptions   =
    devDependencies: true
    bowerJson: bowerJSON
  bowerFiles   = wiredep(wiredepOptions)['js']

  defaultFiles = [
    configs.__dirname + '/tests/specs/helper.coffee'
    configs.__dirname + '/.tmp/scripts/json-fixtures.js'
    configs.__dirname + '/app/scripts/**/*.module.coffee'
    configs.__dirname + '/.tmp/scripts/templates.js'
    configs.__dirname + '/.tmp/scripts/constants.js'
    configs.__dirname + '/app/**/*.coffee'
    configs.__dirname + '/tests/specs/**/*.coffee'
  ]

  defaultFiles = bowerFiles.concat defaultFiles
  files        = configs.karma?.files || defaultFiles

  runTest = (singleRun = true, coverage = true) ->
    preprocessors = {}
    preprocessors[coverageFiles] = if coverage then 'coverage' else 'coffee'

    for coffeeFile in coffeeFiles
      preprocessors[coffeeFile] = 'coffee'

    options =
      basePath        : configs.__dirname
      configFile      : configFile
      singleRun       : singleRun
      preprocessors   : preprocessors
      files           : files
      coverageReporter: coverageReporter

    $.karma.start options

  dependencies = ['ng-constant', 'fixtures', 'template-cache']

  gulp.task 'test', dependencies, ->
    runTest()

  gulp.task 'test-serve', dependencies, ->
    runTest false, false
