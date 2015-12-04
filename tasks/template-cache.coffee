defaultDestPath = '.tmp/scripts'
defaultFileName = 'templates.js'

module.exports = (gulp, $, configs) ->
  configs.templateCache = [configs.templateCache] unless configs.templateCache?.length

  gulp.task 'template-cache', ['jade'], ->
    for config in configs.templateCache
      if config?.files
        src               = gulp.src config.files
        destPath          = config.destPath || defaultDestPath
        dest              = gulp.dest destPath
        fileName          = config.fileName || defaultFileName
        minifyHtmlOptions = config.minifyHtml || {}

        options =
          root      : config.root
          module    : config.module
          standAlone: config.standAlone

        minifyHtml    = $.minifyHtml minifyHtmlOptions
        templateCache = $.angularTemplatecache fileName, options

        src.pipe(minifyHtml).pipe(templateCache).pipe dest
