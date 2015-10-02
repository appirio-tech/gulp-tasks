defaultFiles = [
  'dist/**/*.css'
  'dist/**/*.html'
]
defaultDistPath  = 'dist'

module.exports = (gulp, $, configs) ->
  cdnifyFiles = configs.cdnify?.files || defaultFiles
  distPath    = configs.cdnify?.distPath || defaultDistPath

  gulp.task 'cdnify', ->
    options =
      defaultCDNBase: configs.cdnify?.url
      files         : [
        '/styles/**/*.css'
        '/scripts/**/*.js'
        '/images/**/*.{gif,png,jpg,jpeg,svg}'
      ]

    cdnizer = $.cdnizer options
    src     = gulp.src cdnifyFiles
    dest    = gulp.dest distPath

    src.pipe(cdnizer).pipe dest