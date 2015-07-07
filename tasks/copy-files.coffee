defaultFiles =
  'dist': 'app/**/*.{gif,png,jpg,jpeg,svg}'

module.exports = (gulp, $, configs) ->
  files = configs.copyFiles || defaultFiles

  gulp.task 'copy-files', ->
    for destPath, srcFiles of files
      src  = gulp.src srcFiles
      dest = gulp.dest destPath

      src.pipe dest
