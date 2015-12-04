defaultFiles    = './assets/fonts/**/*.*'
defaultDestPath = 'build/fonts'

module.exports = (gulp, $, configs) ->
  fontFiles = configs.fonts?.srcFiles || defaultFiles
  destPath  = configs.fonts?.destPath || defaultDestPath

  gulp.task 'fonts', ->
    src  = gulp.src fontFiles
    dest = gulp.dest destPath

    src.pipe dest
