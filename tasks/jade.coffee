defaultJadeFiles  = 'app/**/*.jade'
defaultTempFolder = '.tmp'

module.exports = (gulp, $, configs) ->
  jadeFiles  = configs.jadeFiles || defaultJadeFiles
  tempFolder = configs.tempFolder || defaultTempFolder

  gulp.task 'jade', ->
    options =
      pretty: false

    onError = (errors) ->
      red = $.util.colors.red errors.message

      $.util.beep()
      $.util.log red

    jade    = $.jade options
    plumber = $.plumber errorHandler: onError
    src     = gulp.src jadeFiles
    dest    = gulp.dest tempFolder

    src.pipe(plumber).pipe(jade).pipe dest