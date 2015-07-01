defaultFingerPrintFiles = 'dist/**/*'
defaultDistFolder       = 'dist'
defaultTempFolder       = '.tmp'

module.exports = (gulp, $, configs) ->
  fingerPrintFiles = configs.fingerPrintFiles || defaultFingerPrintFiles
  distFolder       = configs.distFolder || defaultDistFolder
  tempFolder       = configs.tempFolder || defaultTempFolder

  gulp.task 'finger-print', ->
    options  = {}
    rev      = $.rev options
    manifest = $.rev.manifest()
    src      = gulp.src fingerPrintFiles
    dest     = gulp.dest distFolder
    tempDest = gulp.dest tempFolder

    src.pipe(rev).pipe(dest).pipe(manifest).pipe tempDest
