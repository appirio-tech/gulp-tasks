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

    gulp.watch configs.scssFiles, ['scss']
    gulp.watch configs.jadeFiles, ['jade']
    gulp.watch configs.coffeeFiles, ['coffee']
