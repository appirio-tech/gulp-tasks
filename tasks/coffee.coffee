module.exports = (gulp, $, configs) ->
  gulp.task 'coffee', ->
    onError = ->
      red = $.util.colors.red 'Coffee error'
      $.util.beep()
      $.util.log red
      console.log arguments

    coffee  = $.coffee bare: false
    plumber = $.plumber errorHandler: onError
    src     = gulp.src configs.coffeeFiles
    reload  = $.browserSync.reload stream: true
    dest    = gulp.dest configs.tempFolder

    src.pipe(plumber).pipe(coffee).pipe(dest).pipe reload