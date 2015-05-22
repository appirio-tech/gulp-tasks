module.exports = (gulp, $, configs) ->
  gulp.task 'jade', ->
    options =
      pretty: false

    onError = (errors) ->
      red = $.util.colors.red 'Jade error'
      $.util.beep()
      $.util.log red

    jade    = $.jade options
    plumber = $.plumber errorHandler: onError
    src     = gulp.src configs.jadeFiles
    dest    = gulp.dest configs.tempFolder
    reload  = $.browserSync.reload stream: true

    src.pipe(plumber).pipe(jade).pipe(dest).pipe reload