defaultJadeFiles   = [
  'app/**/*.jade'
  'example/**/*.jade'
  'src/**/*.jade'
]
defaultTempFolder  = '.tmp'
defaultJadeData    = null
defaultJadeReplace = null
defaultJadeOptions =
  pretty: false

module.exports = (gulp, $, configs) ->
  jadeFiles   = configs.jade?.files || defaultJadeFiles
  jadeOptions = configs.jade?.options || defaultJadeOptions
  jadeData    = configs.jade?.data || defaultJadeData
  jadeReplace = configs.jade?.replace || defaultJadeReplace
  tempFolder  = configs.jade?.tempFolder || defaultTempFolder

  gulp.task 'jade', ->
    options = jadeOptions

    onError = (errors) ->
      red = $.util.colors.red errors.message
      $.util.beep()
      $.util.log red

    getData = (file) ->
      jadeData

    jade    = $.jade options
    data    = $.data getData
    replace = $if jadeReplace, $.replace(jadeReplace.pattern[0], jadeReplace.pattern[1])
    plumber = $.plumber errorHandler: onError
    src     = gulp.src jadeFiles
    dest    = gulp.dest tempFolder

    src.pipe(plumber).pipe(data).pipe(jade).pipe(replace).pipe dest
