defaultUglifyFiles = 'dist/**/*.js'
defaultDistFolder  = 'dist'

module.exports = (gulp, $, configs) ->
  uglifyFiles       = configs.uglifyFiles || defaultUglifyFiles
  defaultDistFolder = configs.distFolder || defaultDistFolder

  gulp.task 'uglify', ->
    options = {}
    uglify = $.uglify options
    src    = gulp.src uglifyFiles
    dest   = gulp.dest defaultDistFolder

    src.pipe(uglify).pipe dest