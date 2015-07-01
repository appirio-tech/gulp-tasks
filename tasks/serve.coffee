defaultSCSSFiles   = 'app/**/*.scss'
defaultJadeFiles   = 'app/**/*.jade'
defaultCoffeeFiles = 'app/**/*.coffee'

module.exports = (gulp, $, configs) ->
  depedencies = ['ng-constant', 'fixtures', 'coffee', 'scss', 'jade']

  baseDir = configs.baseDir || []
  baseDir.push configs.tempFolder
  baseDir.push configs.appFolder

  gulp.task 'serve', depedencies, ->
    options =
      open  : false
      notify: false
      port  : 9000
      server:
        baseDir: baseDir
        routes:
          '/bower_components': 'bower_components'

    $.browserSync options

    watchFiles = [
      configs.tempFolder + '/**/*.{js,css,html}'
      configs.appFolder + '/**/*.{js,css,html}'
    ]

    gulp.watch(watchFiles).on 'change', $.browserSync.reload

    scssFiles   = configs.scssFiles || defaultSCSSFiles
    jadeFiles   = configs.jadeFiles || defaultJadeFiles
    coffeeFiles = configs.coffeeFiles || defaultCoffeeFiles

    gulp.watch scssFiles, ['scss']
    gulp.watch jadeFiles, ['jade']
    gulp.watch coffeeFiles, ['coffee']
