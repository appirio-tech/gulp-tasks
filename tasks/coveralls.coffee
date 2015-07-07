defaultCoverageReporter =
  type: 'lcov'
  dir: 'coverage'

module.exports = (gulp, $, configs) ->
  coverageReporter = configs.coverageReporter || defaultCoverageReporter

  gulp.task 'coveralls', ->
    lcov = coverageReporter.dir + '/**/lcov.info'
    src  = gulp.src lcov

    src.pipe $.coveralls()