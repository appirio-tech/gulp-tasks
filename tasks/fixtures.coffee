defaultFixtureFiles = 'bower_components/appirio-tech-api-schemas/swagger/**/*.json'
defaultDestPath     = '.tmp/scripts'
defaultDestName     = 'json-fixtures.js'

module.exports = (gulp, $, configs) ->
  fixtureFiles = configs.fixture?.files || defaultFixtureFiles
  destName     = configs.fixture?.destName || defaultDestName
  destPath     = configs.fixture?.destPath || defaultDestPath

  gulp.task 'fixtures', ->
    src  = gulp.src fixtureFiles
    dest = gulp.dest destPath

    options =
      postProcessors:
        '**/*.json': 'json'

    fixtures = $.fixtures2js destName, options

    src.pipe(fixtures).pipe(dest)

