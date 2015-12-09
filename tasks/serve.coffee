modRewrite = require 'connect-modrewrite'
_          = require 'lodash'

defaultPort             = 9000
defaultServeFolders     = ['src', 'app', 'example', '.tmp']
defaultSpecServeFolders = ['./']
defaultSCSSFiles        = []
defaultJadeFiles        = []
defaultCoffeeFiles      = []
defaultReloadFiles      = []
defaultDependencies     = ['preprocessors']
defaultSpecDependencies = ['build-specs:topcoder']

for folder in defaultServeFolders
  scss   = folder + '/**/*.scss'
  jade   = folder + '/**/*.jade'
  coffee = folder + '/**/*.coffee'
  reload = folder + '/**/*.{js,css,html}'

  defaultSCSSFiles.push scss
  defaultJadeFiles.push jade
  defaultCoffeeFiles.push coffee
  defaultReloadFiles.push reload

module.exports = (gulp, $, configs) ->
  depedencies          = configs.serve?.dependencies || defaultDependencies
  specDependencies     = configs.serve?.specDependencies || defaultSpecDependencies
  port                 = configs.serve?.port || defaultPort
  reloadFiles          = configs.serve?.reloadFiles || defaultReloadFiles
  scssFiles            = configs.serve?.scssFiles || defaultSCSSFiles
  jadeFiles            = configs.serve?.jadeFiles || defaultJadeFiles
  coffeeFiles          = configs.serve?.coffeeFiles || defaultCoffeeFiles
  serveFolders         = configs.serve?.serveFolders || defaultServeFolders
  specServeFolders     = configs.serve?.specServeFolders || defaultSpecServeFolders
  optionOverwrites     = configs.serve?.options || {}
  specOptionOverwrites = configs.serve?.specOptions || {}

  gulp.task 'serve', depedencies, ->
    options =
      open       : false
      notify     : false
      port       : port
      reloadDelay: 1000
      logPrefix  : configs.__dirname
      server:
        baseDir: serveFolders
        middleware: [
          # https://github.com/BrowserSync/browser-sync/issues/554
          modRewrite [
            '^[^\\.]*$ /index.html [L]'
          ]
        ]
        routes:
          '/bower_components': 'bower_components'

    _.assign options, optionOverwrites

    $.browserSync options

    if !options.files?.length
      gulp.watch(reloadFiles).on 'change', ->
        $.browserSync.reload()

      gulp.watch reloadFiles, ['useref-temp']

    gulp.watch scssFiles, ['scss']
    gulp.watch jadeFiles, ['template-cache']
    gulp.watch coffeeFiles, ['coffee']

  gulp.task 'serve-specs', specDependencies, ->
    # Run the spec runner
    options =
      open       : false
      notify     : false
      port       : port
      reloadDelay: 1000
      logPrefix  : configs.__dirname
      server:
        baseDir: specServeFolders
        middleware: [
          # https://github.com/BrowserSync/browser-sync/issues/554
          modRewrite [
            '^[^\\.]*$ /index.html [L]'
          ]
        ]
        routes:
          '/bower_components': 'bower_components'

    _.assign options, specOptionOverwrites

    $.browserSync options

    if !options.files?.length
      gulp.watch(reloadFiles).on 'change', ->
        $.browserSync.reload()

    gulp.watch scssFiles, ['scss']
    gulp.watch jadeFiles, ['template-cache']
    gulp.watch coffeeFiles, ['coffee']
