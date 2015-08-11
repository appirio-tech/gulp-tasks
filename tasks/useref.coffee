defaultFiles      = '.tmp/index.html'
defaultDestPath   = 'dist'
defaultSearchPath = ['.tmp', 'app', '.', 'src']

module.exports = (gulp, $, configs) ->
  files      = configs.useref?.files || defaultFiles
  destPath   = configs.useref?.destPath || defaultDestPath
  searchPath = configs.useref?.searchPath || defaultSearchPath

  gulp.task 'useref', ->
    assetsOptions =
      searchPath: searchPath

    assets  = $.useref.assets assetsOptions
    restore = assets.restore()
    useref  = $.useref()
    src     = gulp.src files
    dest    = gulp.dest destPath

    src.pipe(assets).pipe(restore).pipe(useref).pipe dest
