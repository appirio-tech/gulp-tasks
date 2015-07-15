wiredep                 = require 'wiredep'
defualtConfigFile       = '../karma.conf.coffee'
defaultCoverageReporter =
  type: 'lcov'
  dir: 'coverage'

module.exports = (gulp, $, configs) ->
  defaultCoffeeFiles   = [configs.__dirname + '/tests/specs/**/*.coffee'] # Dont include coverage files
  coffeeFiles          = configs.karma?.coffeeFiles || defaultCoffeeFiles
  defaultCoverageFiles = [
    configs.__dirname + '/app/**/*.coffee'
    configs.__dirname + '/src/**/*.coffee'
  ]
  configFile           = configs.karma?.configFile || defualtConfigFile
  coverageFiles        = configs.karma?.coverage || defaultCoverageFiles
  coverageReporter     = configs.coverageReporter || defaultCoverageReporter
  basePath             = configs.karma?.basePath || configs.__dirname || '.'

  if configs.__dirname
    bowerJSONPath = configs.__dirname + '/./bower.json'
    bowerJSON     = require bowerJSONPath

  wiredepOptions   =
    devDependencies: true
    bowerJson      : bowerJSON

  bowerFiles   = wiredep(wiredepOptions)['js']

  defaultFiles = [
    configs.__dirname + '/tests/specs/helper.coffee'
    configs.__dirname + '/.tmp/scripts/json-fixtures.js'
    configs.__dirname + '/app/scripts/**/*.module.coffee'
    configs.__dirname + '/app/scripts/**/*.module.js'
    configs.__dirname + '/src/scripts/**/*.module.coffee'
    configs.__dirname + '/src/scripts/**/*.module.js'
    configs.__dirname + '/.tmp/scripts/templates.js'
    configs.__dirname + '/.tmp/scripts/constants.js'
    configs.__dirname + '/app/**/*.coffee'
    configs.__dirname + '/app/**/*.js'
    configs.__dirname + '/src/**/*.coffee'
    configs.__dirname + '/src/**/*.js'
    configs.__dirname + '/tests/specs/**/*.coffee'
  ]

  defaultFiles = bowerFiles.concat defaultFiles if bowerFiles
  files        = configs.karma?.files || defaultFiles

  runTest = (singleRun = true, coverage = true) ->
    preprocessors = {}
    preprocessors[coverageFiles] = if coverage then 'coverage' else 'coffee'

    for coffeeFile in coffeeFiles
      preprocessors[coffeeFile] = 'coffee'

    options =
      basePath        : basePath
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
