defaultSCSSFiles  = [
  'app/**/*.scss'
  'example/**/*.scss'
  'src/**/*.scss'
]
defaultSrcOptions  = {}
defaultTempFolder  = '.tmp'

module.exports = (gulp, $, configs) ->
  scssFiles        = configs.scss?.scssFiles || defaultSCSSFiles
  srcOptions       = configs.scss?.sourceOptions || defaultSrcOptions
  tempFolder       = configs.scss?.tempFolder || defaultTempFolder
  autoprefixerOps  = configs.scss?.autoprefixer || null
  assetPrefix      = configs.scss?.assetPrefix || null
  replaceOptions   = configs.scss?.replace || null
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
    src              = gulp.src scssFiles, srcOptions
    dest             = gulp.dest tempFolder
    sourceMaps       = $.sourcemaps.init()
    soureceMapsWrite = $.sourcemaps.write()
    stop             = $.plumber.stop()
    replace          = $.replace replaceOptions, assetPrefix
    autoprefixer     = $.autoprefixer autoprefixerOps

    src
      .pipe(sourceMaps)
      .pipe(scss)
      .pipe($.if(autoprefixerOps, autoprefixer))
      .pipe($.if(replaceOptions, replace)
      .pipe(soureceMapsWrite)
      .pipe dest
