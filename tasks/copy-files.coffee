module.exports = (gulp, $, configs) ->
  files = configs.copyFiles || {}

  gulp.task 'copy-files', ->
    for destPath, srcFiles of files
      src  = gulp.src srcFiles
      dest = gulp.dest destPath

      src.pipe dest
