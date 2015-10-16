flatten = require 'gulp-flatten'

defaultFiles =
  '.tmp/images': 'bower_components/**/*.{gif,png,jpg,jpeg,svg}'

module.exports = (gulp, $, configs) ->
  files = configs.bowerImages?.files || defaultFiles

  gulp.task 'bower-images', ->
    for destPath, srcFiles of files
      src  = gulp.src srcFiles
      dest = gulp.dest destPath

      src.pipe(flatten()).pipe dest
