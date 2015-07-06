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
      defaultCDNBase: 'https://ap-work-client-site-dev.s3.amazonaws.com'
      files         : ['**/*.{gif,png,jpg,jpeg,svg,woff2,js,css}']

    cdnizer = $.cdnizer options
    src     = gulp.src cdnifyFiles
    dest    = gulp.dest defaultDistFolder

    src.pipe(cdnizer).pipe dest