defaultFiles =
  'dist': '**/*.{gif,png,jpg,jpeg,svg}'

defaultBases = ['app/', 'src/', '.tmp/']

module.exports = (gulp, $, configs) ->
  files = configs.copyFiles?.files || defaultFiles
  bases = configs.copyFiles?.base || defaultBases
  bases = [bases] if typeof(bases) == 'string'

  gulp.task 'copy-files', ->
    for destPath, srcFiles of files
      for base in bases
        options =
          base: base
          dot: true

        src  = gulp.src srcFiles, options
        dest = gulp.dest destPath

        src.pipe dest
