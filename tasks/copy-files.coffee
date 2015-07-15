defaultFiles =
  'dist': '**/*.{gif,png,jpg,jpeg,svg}'

defaultBases = ['app/', 'src/']

module.exports = (gulp, $, configs) ->
  files = configs.copyFiles?.files || defaultFiles
  bases = configs.copyFiles?.base || defaultBases
  bases = [bases] if typeof(bases) == 'string'

  gulp.task 'copy-files', ->
    for destPath, srcFiles of files
      for base in bases
        src  = gulp.src srcFiles, base: base
        dest = gulp.dest destPath

        src.pipe dest
