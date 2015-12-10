defaultCjsxFiles = [
  'app/**/*.cjsx'
  'example/**/*.cjsx'
  'src/**/*.cjsx'
]
defaultTempFolder  = '.tmp'

module.exports = (gulp, $, configs) ->
  cjsxFiles = configs.cjsx?.files || defaultCjsxFiles
  tempFolder  = configs.cjsx?.tempFolder || defaultTempFolder

  gulp.task 'cjsx', ->
    onError = ->
      red = $.util.colors.red 'Cjsx error'
      $.util.beep()
      $.util.log red
      console.log arguments

    cjsx  = $.cjsx bare: false
    plumber = $.plumber errorHandler: onError
    src     = gulp.src cjsxFiles
    dest    = gulp.dest tempFolder

    src.pipe(plumber).pipe(cjsx).pipe dest