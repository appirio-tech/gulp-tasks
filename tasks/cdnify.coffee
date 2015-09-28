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
      files         : ['/**/*.{gif,png,jpg,jpeg,svg,woff2,js,css}']

    cdnizer = $.cdnizer options
    src     = gulp.src cdnifyFiles
    dest    = gulp.dest distPath

    src.pipe(cdnizer).pipe dest