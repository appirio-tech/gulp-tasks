defaultFiles =
  'dist': '**/*.{gif,png,jpg,jpeg,svg}'

defaultBase = 'app/'

module.exports = (gulp, $, configs) ->
  files = configs.copyFiles?.files || defaultFiles
  base  = configs.copyFiles?.base || defaultBase

  gulp.task 'copy-files', ->
    for destPath, srcFiles of files
      src  = gulp.src srcFiles, base: base
      dest = gulp.dest destPath

      src.pipe dest
