defaultFiles      = 'dist/index.html'
defaultDestPath   = 'dist'

module.exports = (gulp, $, configs) ->
  files      = configs.removeCode?.files || defaultFiles
  destPath   = configs.removeCode?.destPath || defaultDestPath

  gulp.task 'remove-code', ->
    options =
      production: true

    removeCode = $.removeCode options
    src        = gulp.src files
    dest       = gulp.dest destPath

    src.pipe(removeCode).pipe dest
