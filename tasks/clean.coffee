defaultCleanFiles = [
  '.tmp'
  'dist'
  'coverage'
]

module.exports = (gulp, $, configs) ->
  defaultCleanFiles = configs.cleanFiles || defaultCleanFiles

  gulp.task 'clean', ->
    src   = gulp.src defaultCleanFiles, read: false
    clean = $.clean()

    src.pipe clean