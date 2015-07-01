defaultCdnifyFiles = [
  'dist/**/*.css'
  'dist/**/*.html'
]
defaultDistFolder  = 'dist'

module.exports = (gulp, $, configs) ->
  cdnifyFiles       = configs.cdnifyFiles || defaultCdnifyFiles
  defaultDistFolder = configs.distFolder || defaultDistFolder

  gulp.task 'cdnify', ->
    options =
      defaultCDNBase: '//my.cdn.url/'
      files         : ['**/*.{gif,png,jpg,jpeg,svg,woff2,js,css}']

    cdnizer = $.cdnizer options
    src     = gulp.src cdnifyFiles
    dest    = gulp.dest defaultDistFolder

    src.pipe(cdnizer).pipe dest