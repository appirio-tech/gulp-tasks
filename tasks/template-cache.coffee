module.exports = (gulp, $, configs) ->
  gulp.task 'template-cache', ['jade'], ->
    src           = gulp.src configs.templateCacheFiles
    dest          = gulp.dest(configs.tempFolder + '/scripts')
    templateCache = $.angularTemplatecache()

    src.pipe(templateCache).pipe dest
