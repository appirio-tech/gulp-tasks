defaultSCSSFiles = [
  'app/**/*.scss'
  'example/**/*.scss'
  'src/**/*.scss'
]
defaultTempFolder = '.tmp'

module.exports = (gulp, $, configs) ->
  scssFiles        = configs.scss?.scssFiles || defaultSCSSFiles
  tempFolder       = configs.scss?.tempFolder || defaultTempFolder
  scssIncludePaths = configs.scss?.includePaths || [
    configs.__dirname + '/node_modules/appirio-work-styles/node_modules/node-neat/node_modules/node-bourbon/node_modules/bourbon/app/assets/stylesheets'
    configs.__dirname + '/node_modules/appirio-work-styles/node_modules/node-neat/node_modules/bourbon-neat/app/assets/stylesheets'
    configs.__dirname + '/node_modules/appirio-work-styles/styles'
    configs.__dirname + '/node_modules/appirio-styles/node_modules/node-neat/node_modules/node-bourbon/node_modules/bourbon/app/assets/stylesheets'
    configs.__dirname + '/node_modules/appirio-styles/node_modules/node-neat/node_modules/bourbon-neat/app/assets/stylesheets'
    configs.__dirname + '/node_modules/appirio-styles/styles'
  ]

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
