# https://gist.github.com/demisx/9512212
defaultTests        = ['tests/e2e/**/*.{js,coffee}']
defualtConfigFile   = '/protractor.config.js'
defaultServeFolders = ['dist']
defaultPort         = 9000

module.exports = (gulp, $, configs) ->
  defualtConfigFile   = configs.__dirname + defualtConfigFile
  port                = configs.e2eTest?.port || defaultPort
  serveFolders        = configs.e2eTest?.serveFolders || defaultServeFolders
  tests               = configs.e2eTest?.tests || defaultTests
  configFile          = configs.e2eTest?.configFile || defualtConfigFile
  webdriverStandalone = $.protractor.webdriver_standalone
  webdriverUpdate     = $.protractor.webdriver_update
  protractor          = $.protractor.protractor

  gulp.task 'webdriver_update', webdriverUpdate

  gulp.task 'webdriver_standalone', webdriverStandalone

  gulp.task 'e2e-test-serve', ->
    options =
      root: serveFolders
      port: port

    $.connect.server options

  gulp.task 'e2e-test-run', ['webdriver_update', 'e2e-test-serve'], ->
    options =
      configFile: configFile
      debug     : false

    protractored = protractor options
    src          = gulp.src tests

    onError = (e) ->
      throw e

    src.pipe(protractored).on 'error', onError

  gulp.task 'e2e-test', ['e2e-test-run'], ->
    process.exit()
