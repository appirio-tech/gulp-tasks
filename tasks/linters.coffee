args = require('yargs').argv

defaultFiles = [
  './app/**/*.js'
  './*.js'
]

module.exports = (gulp, $, configs) ->
  jsFiles = configs.linters?.srcFiles || defaultFiles

  gulp.task 'vet', ->
    src = gulp.src jsFiles

    src
      .pipe $.jscs()
      .pipe $.jshint()
      .pipe $.jscs.reporter()
      .pipe $.jscs.reporter('fail')
      .pipe $.jshint.reporter('jshint-stylish', verbose: true)
      .pipe $.jshint.reporter('fail')
