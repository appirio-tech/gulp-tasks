defaultFiles    = './assets/images/**/*.*'
defaultDestPath = '.tmp/images'
defaultOptions  =
  optimizationLevel: 4

module.exports = (gulp, $, configs) ->
  imageFiles = configs.images?.srcFiles || defaultFiles
  destPath   = configs.images?.destPath || defaultDestPath
  options    = configs.images?.options || defaultOptions

  gulp.task 'images', ->
    src            = gulp.src imageFiles
    optimizeImages = $.imagemin options
    dest           = gulp.dest destPath

    src.pipe(optimizeImages).pipe dest
