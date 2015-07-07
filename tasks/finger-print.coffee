defaultFiles        = 'dist/**/*'
defaultDistPath     = 'dist'
defaultManifestPath = '.tmp'

module.exports = (gulp, $, configs) ->
  files    = configs.fingerPrint?.files || defaultFiles
  distPath = configs.fingerPrint?.destPath || defaultDistPath
  tempPath = configs.fingerPrint?.manifestPath || defaultManifestPath

  gulp.task 'finger-print', ->
    options  = {}
    rev      = $.rev options
    manifest = $.rev.manifest()
    src      = gulp.src files
    dest     = gulp.dest distPath
    tempDest = gulp.dest tempPath

    src.pipe(rev).pipe(dest).pipe(manifest).pipe tempDest
