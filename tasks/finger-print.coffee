defaultFingerPrintFiles = 'dist/**/*'
defaultDistFolder       = 'dist'

module.exports = (gulp, $, configs) ->
  fingerPrintFiles  = configs.fingerPrintFiles || defaultFingerPrintFiles
  defaultDistFolder = configs.distFolder || defaultDistFolder

  gulp.task 'finger-print', ->
    options = {}
    rev     = $.rev options
    src     = gulp.src fingerPrintFiles
    dest    = gulp.dest defaultDistFolder

    src.pipe(rev).pipe dest