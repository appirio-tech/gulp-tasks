defaultUglifyFiles = 'dist/**/*.js'
defaultDistFolder  = 'dist'

module.exports = (gulp, $, configs) ->
  uglifyFiles       = configs.uglify?.files || defaultUglifyFiles
  defaultDistFolder = configs.uglify?.distFolder || defaultDistFolder

  gulp.task 'uglify', ->
    options =
      mangle  : true
      compress: true
      output  :
        beautify: false

    uglify = $.uglify options
    src    = gulp.src uglifyFiles
    dest   = gulp.dest defaultDistFolder

    src.pipe(uglify).pipe dest