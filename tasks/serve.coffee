modRewrite = require 'connect-modrewrite'

defaultPort         = 9000
defaultServeFolders = ['src', 'app', 'example', '.tmp']
defaultSCSSFiles    = []
defaultJadeFiles    = []
defaultCoffeeFiles  = []
defaultReloadFiles  = []

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
  depedencies   = ['ng-constant', 'fixtures', 'coffee', 'scss', 'template-cache']
  port          = configs.serve?.port || defaultPort
  reloadFiles   = configs.serve?.reloadFiles || defaultReloadFiles
  scssFiles     = configs.serve?.scssFiles || defaultSCSSFiles
  jadeFiles     = configs.serve?.jadeFiles || defaultJadeFiles
  coffeeFiles   = configs.serve?.coffeeFiles || defaultCoffeeFiles
  serveFolders  = configs.serve?.serveFolders || defaultServeFolders

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
          modRewrite [
            '!\\.\\w+$ /index.html [L]'
          ]
        ]
        routes:
          '/bower_components': 'bower_components'

    $.browserSync options

    gulp.watch(reloadFiles).on 'change', ->
      $.browserSync.reload()

    gulp.watch scssFiles, ['scss']
    gulp.watch jadeFiles, ['template-cache']
    gulp.watch coffeeFiles, ['coffee']
