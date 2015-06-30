defaultUglifyFiles = 'dist/**/*.js'
defaultDistFolder  = 'dist'

module.exports = (gulp, $, configs) ->
  scssFiles         = configs.scssFiles || defaultUglifyFiles
  defaultDistFolder = configs.distFolder || defaultDistFolder

  gulp.task 'uglify', ->
    options =
      mangle  : false
      compress: false
      output  :
        beautify: true

    uglify = $.uglify options
    src    = gulp.src defaultUglifyFiles
    dest   = gulp.dest defaultDistFolder

    src.pipe(uglify).pipe dest