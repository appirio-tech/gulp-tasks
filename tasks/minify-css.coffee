defaultMinifyCSSFiles = 'dist/**/*.css'
defaultDistFolder     = 'dist'

module.exports = (gulp, $, configs) ->
  minifyCssFiles    = configs.minifyCss?.files || defaultMinifyCSSFiles
  defaultDistFolder = configs.minifyCss?.distFolder || defaultDistFolder

  gulp.task 'minify-css', ->
    options   = {}
    minifyCss = $.minifyCss options
    src       = gulp.src minifyCssFiles
    dest      = gulp.dest defaultDistFolder

    src.pipe(minifyCss).pipe dest