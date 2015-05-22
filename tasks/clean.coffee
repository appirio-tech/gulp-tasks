module.exports = (gulp, $, configs) ->
  gulp.task 'clean', ->
    files = [
      configs.tempFolder + '/**/*.*'
      configs.distFolder + '/**/*.*'
    ]
    src   = gulp.src files, read: false
    clean = $.clean()

    src.pipe clean