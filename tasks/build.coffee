module.exports = (gulp, $, configs) ->

  dependencies = [
    'ng-constant'
    'template-cache'
    'scss'
    'coffee'
  ]

  gulp.task 'preprocessors', dependencies, ->
    # nothing

  optimizeDependencies = [
    'cdnify'
    'uglify'
    'minify-css'
    'remove-code'
  ]

  gulp.task 'optimize-build', optimizeDependencies, ->
    # should run build before this

