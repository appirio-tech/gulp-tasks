defaultDistFolder  = 'dist'
defaultCopyFiles   = ['app/images/**/*']
defaultConcatFiles =
  'main.js': [
    '.tmp/scripts/**/*.module.js'
    '.tmp/scripts/**/*.controller.js'
    '.tmp/scripts/**/*.service.js'
    '.tmp/scripts/**/*.directive.js'
    '.tmp/scripts/**/*.filter.js'
  ]
  'main.portrait.css': ['.tmp/styles/**/*.portrait.css']
  'main.landscape.css': ['.tmp/styles/**/*.landscape.css']
  'main.desktop.css': ['.tmp/styles/**/*.desktop.css']

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
    buildConcat()

  optimizeDependencies = [
    'cdnify'
    'uglify'
    'minify-css'
  ]

  gulp.task 'optimize-build', optimizeDependencies, ->
    # should run build before this

