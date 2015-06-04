module.exports = (gulp, $, configs) ->
  gulp.task 'clean', ->
    files = [
      configs.tempFolder + '/**'
      configs.distFolder + '/**'
      configs.distFolder + '/**'
      configs.coverageReporter.dir + '/**'
    ]
    src   = gulp.src files, read: false
    clean = $.clean()

    src.pipe clean