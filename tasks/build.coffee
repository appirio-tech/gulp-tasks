module.exports = (gulp, $, configs) ->

  dependencies = [
    'ng-constant'
    'fixtures'
    'template-cache'
    'scss'
    'coffee'
  ]

  gulp.task 'preprocessors', dependencies, ->
    # nothing

  ## DEPRECATED, DO NOT USE ##
  optimizeDependencies = [
    'cdnify'
    'uglify'
    'minify-css'
    'remove-code'
  ]

  gulp.task 'optimize-build', optimizeDependencies, ->
    # should run build before this

