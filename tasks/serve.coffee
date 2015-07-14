defaultSCSSFiles     = 'app/**/*.scss'
defaultJadeFiles     = 'app/**/*.jade'
defaultCoffeeFiles   = 'app/**/*.coffee'
defaultExampleFolder = 'example'
defaultPort          = 9000

module.exports = (gulp, $, configs) ->
  depedencies = ['ng-constant', 'fixtures', 'coffee', 'scss', 'template-cache']
  exampleFolder = configs.exampleFolder || defaultExampleFolder
  port        = configs.serve?.port || defaultPort

  baseDir = configs.baseDir || []
  baseDir.push configs.tempFolder
  baseDir.push configs.appFolder
  baseDir.push exampleFolder

  gulp.task 'serve', depedencies, ->
    options =
      open  : false
      notify: false
      port  : port
      server:
        baseDir: baseDir
        routes:
          '/bower_components': 'bower_components'

    $.browserSync options

    watchFiles = [
      configs.tempFolder + '/**/*.{js,css,html}'
      configs.appFolder + '/**/*.{js,css,html}'
      exampleFolder + '/**/*.{js,css,html}'
    ]

    gulp.watch(watchFiles).on 'change', $.browserSync.reload

    scssFiles   = configs.scssFiles || defaultSCSSFiles
    jadeFiles   = configs.jadeFiles || defaultJadeFiles
    coffeeFiles = configs.coffeeFiles || defaultCoffeeFiles

    gulp.watch scssFiles, ['scss']
    gulp.watch jadeFiles, ['template-cache']
    gulp.watch coffeeFiles, ['coffee']
