defaultDestPath = '.tmp/scripts'
defaultFileName = 'templates.js'

module.exports = (gulp, $, configs) ->
  configs.templateCache = [configs.templateCache] unless configs.templateCache?.length

  gulp.task 'template-cache', ['jade'], ->
    for config in configs.templateCache
      if config?.files
        src      = gulp.src config.files
        destPath = config.destPath || defaultDestPath
        dest     = gulp.dest destPath
        fileName = config.fileName || defaultFileName
        options  =
          root      : config.root
          module    : config.module
          standAlone: config.standAlone

        templateCache = $.angularTemplatecache fileName, options

        src.pipe(templateCache).pipe dest
