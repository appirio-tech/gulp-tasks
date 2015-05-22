module.exports = (gulp, $, configs) ->
  depedencies = ['ng-constant', 'fixtures', 'coffee', 'scss', 'jade']

  gulp.task 'serve', depedencies, ->
    options =
      open  : false
      notify: false
      port  : 9000
      server:
        baseDir: [configs.tempFolder, configs.appFolder]
        routes:
          '/bower_components': 'bower_components'

    $.browserSync options

    watchFiles = [
      configs.jadeFiles
      configs.scssFiles
      configs.coffeeFiles
    ]

    gulp.watch(watchFiles).on 'change', $.browserSync.reload

    gulp.watch configs.scssFiles, ['scss']
    gulp.watch configs.jadeFiles, ['jade']
    gulp.watch configs.coffeeFiles, ['coffee']
