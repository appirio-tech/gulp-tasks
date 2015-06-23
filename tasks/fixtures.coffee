defaultFixtureFiles = 'bower_components/appirio-tech-api-schemas/swagger/**/*.json'
defaultTempFolder   = '.tmp'

module.exports = (gulp, $, configs) ->
  fixtureFiles = configs.fixtureFiles || defaultFixtureFiles
  tempFolder   = configs.tempFolder || defaultTempFolder

  gulp.task 'fixtures', ->
    src  = gulp.src fixtureFiles
    dest = gulp.dest tempFolder

    options =
      postProcessors:
        '**/*.json': 'json'

    fixtures = $.fixtures2js 'scripts/json-fixtures.js', options

    src.pipe(fixtures).pipe(dest)

