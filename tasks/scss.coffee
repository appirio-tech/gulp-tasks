defaultSCSSFiles = [
  'app/**/*.scss'
  'example/**/*.scss'
  'src/**/*.scss'
]
defaultTempFolder       = '.tmp'
defaultSCSSIncludePaths = require('node-neat').includePaths

module.exports = (gulp, $, configs) ->
  scssFiles        = configs.scss?.scssFiles || defaultSCSSFiles
  tempFolder       = configs.scss?.tempFolder || defaultTempFolder
  scssIncludePaths = configs.scss?.includePaths || defaultSCSSIncludePaths

  gulp.task 'scss', ->
    onError = ->
      red = $.util.colors.red 'SCSS error'
      $.util.beep()
      $.util.log red
      console.log arguments

    options =
      includePaths: scssIncludePaths
      onError     : onError

    scss             = $.sass options
    src              = gulp.src scssFiles
    dest             = gulp.dest tempFolder
    sourceMaps       = $.sourcemaps.init()
    soureceMapsWrite = $.sourcemaps.write()
    stop             = $.plumber.stop()

    src.pipe(sourceMaps).pipe(scss).pipe(soureceMapsWrite).pipe dest
