module.exports = (gulp, $, configs) ->
  gulp.task 'fixtures', ->
    src  = gulp.src configs.fixtureFiles
    dest = gulp.dest configs.tempFolder

    options =
      postProcessors:
        '**/*.json': 'json'

    fixtures = $.fixtures2js 'scripts/json-fixtures.js', options

    src.pipe(fixtures).pipe(dest)

