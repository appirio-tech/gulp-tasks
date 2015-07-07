defaultManifest = '.tmp/rev-manifest.json'
defaultFiles    = 'dist/**/*'
defaultDistPath = 'dist'

module.exports = (gulp, $, configs) ->
  files    = configs.fingerPrintReplace?.files || defaultFiles
  manifest = configs.fingerPrintReplace?.manifest || defaultManifest
  distPath = configs.fingerPrintReplace?.destPath || defaultDistPath

  gulp.task 'finger-print-replace', ->
    manifest   = gulp.src manifest
    options    =
      manifest: manifest
    revReplace = $.revReplace options
    src        = gulp.src files
    dest       = gulp.dest distPath

    src.pipe(revReplace).pipe dest
