module.exports = (gulp, $, configs) ->
  gulp.task 'template-cache', ['jade'], ->
    if configs.templateCache
      src     = gulp.src configs.templateCache.files
      dest    = gulp.dest(configs.tempFolder + '/scripts')
      options =
        root  : configs.templateCache.root
        module: configs.templateCache.module

      templateCache = $.angularTemplatecache options

      src.pipe(templateCache).pipe dest
