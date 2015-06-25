module.exports = (gulp, $, configs) ->
  gulp.task 'jade', ->
    if configs.jadeFiles
      options =
        pretty: false

      onError = (errors) ->
        red = $.util.colors.red errors.message

        $.util.beep()
        $.util.log red

      jade    = $.jade options
      plumber = $.plumber errorHandler: onError
      src     = gulp.src configs.jadeFiles
      dest    = gulp.dest configs.tempFolder

      src.pipe(plumber).pipe(jade).pipe dest