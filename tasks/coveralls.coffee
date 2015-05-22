module.exports = (gulp, $, configs) ->
  gulp.task 'coveralls', ->
    lcov = configs.coverageReporter.dir + '/**/lcov.info'
    src  = gulp.src lcov

    src.pipe $.coveralls()