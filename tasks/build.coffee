module.exports = (gulp, $, configs) ->
  buildCopy = ->
    if configs.buildFiles?.copy
      dest = gulp.dest configs.distFolder

      for path in configs.buildFiles.copy
        src = gulp.src path

        src.pipe dest

  buildConcat = ->
    if configs.buildFiles?.concat
      for to, from of configs.buildFiles.concat
        concated = $.concat to
        src      = gulp.src from
        dest     = gulp.dest configs.distFolder

        src.pipe(concated).pipe dest

  dependencies = [
    'ng-constant'
    'jade'
    'scss'
    'coffee'
  ]

  gulp.task 'build', dependencies, ->
    buildCopy()
    buildConcat()