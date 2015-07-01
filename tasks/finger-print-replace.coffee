defaultManifestFile            = '.tmp/rev-manifest.json'
defaultFingerPrintReplaceFiles = 'dist/**/*'
defaultDistFolder              = 'dist'

module.exports = (gulp, $, configs) ->
  fingerPrintReplaceFiles = configs.fingerPrintReplaceFiles || defaultFingerPrintReplaceFiles
  manifestFile            = configs.fingerPrintManifestFile || defaultManifestFile
  distFolder              = configs.distFolder || defaultDistFolder

  gulp.task 'finger-print-replace', ->
    manifest   = gulp.src manifestFile
    options    =
      manifest: manifest
    revReplace = $.revReplace options
    src        = gulp.src fingerPrintReplaceFiles
    dest       = gulp.dest distFolder

    src.pipe(revReplace).pipe dest
