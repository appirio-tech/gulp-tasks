defaultDestPath = '.tmp/scripts'

module.exports = (gulp, $, configs) ->
  destPath = configs.templateCache.destPath || defaultDestPath

  gulp.task 'template-cache', ['jade'], ->
    if configs.templateCache
      src     = gulp.src configs.templateCache.files
      dest    = gulp.dest destPath
      options =
        root  : configs.templateCache.root
        module: configs.templateCache.module

      templateCache = $.angularTemplatecache options

      src.pipe(templateCache).pipe dest
