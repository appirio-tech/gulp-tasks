defaultUglifyFiles = 'dist/**/*.js'
defaultDistFolder  = 'dist'
defaultOptions     =
  mangle  : true
  compress: true
  output  :
    beautify: false

module.exports = (gulp, $, configs) ->
  uglifyFiles       = configs.uglify?.files || defaultUglifyFiles
  defaultDistFolder = configs.uglify?.distFolder || defaultDistFolder
  options           = configs.uglify?.options || defaultOptions

  gulp.task 'uglify', ->
    uglify = $.uglify options
    src    = gulp.src uglifyFiles
    dest   = gulp.dest defaultDistFolder

    src.pipe(uglify).pipe dest