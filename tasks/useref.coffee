defaultFiles        = '.tmp/index.html'
defaultDestPath     = 'dist'
defaultDestTempPath = 'dist-temp'
defaultSearchPath   = ['.tmp', 'app', '.', 'src']

module.exports = (gulp, $, configs) ->
  files        = configs.useref?.files || defaultFiles
  destPath     = configs.useref?.destPath || defaultDestPath
  destTempPath = configs.useref?.destTempPath || defaultDestTempPath
  searchPath   = configs.useref?.searchPath || defaultSearchPath

  runUseref = (destPath) ->
    assetsOptions =
      searchPath: searchPath

    assets  = $.useref.assets assetsOptions
    restore = assets.restore()
    useref  = $.useref()
    src     = gulp.src files
    dest    = gulp.dest destPath

    src.pipe(assets).pipe(restore).pipe(useref).pipe dest

  gulp.task 'useref', ->
    runUseref destPath

  # useref-temp is used for creating a folder that can be symlink
  gulp.task 'useref-temp', ->
    destPath = 'dist-temp'

    runUseref destTempPath