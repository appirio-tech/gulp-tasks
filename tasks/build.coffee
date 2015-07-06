defaultDistFolder  = 'dist'
defaultCopyFiles   = ['app/images/**/*']

module.exports = (gulp, $, configs) ->
  distFolder = configs.distFolder || defaultDistFolder

  buildCopy = ->
    copyFiles = defaultCopyFiles || configs.buildFiles?.copy
    dest      = gulp.dest distFolder

    for path in defaultCopyFiles
      src = gulp.src path

      src.pipe dest

  buildConcat = ->
    concatFiles = defaultConcatFiles || configs.buildFiles?.concat

    for to, from of concatFiles
      concated = $.concat to
      src      = gulp.src from
      dest     = gulp.dest distFolder

      src.pipe(concated).pipe dest

  dependencies = [
    'ng-constant'
    'template-cache'
    'scss'
    'coffee'
  ]

  gulp.task 'build', dependencies, ->
    buildCopy()

  optimizeDependencies = [
    'cdnify'
    'uglify'
    'minify-css'
    'remove-code'
  ]

  gulp.task 'optimize-build', optimizeDependencies, ->
    # should run build before this

