eventStream = require 'event-stream'

defaultTemplateCacheConfig =
  files: './app/**/*.js'
  destPath: '.tmp/scripts'
  fileName: 'templates.js'

module.exports = (gulp, $, configs) ->
  templateCacheConfig = configs.templateCache || defaultTemplateCacheConfig
  configs.templateCache = [templateCacheConfig] unless templateCacheConfig.length

  gulp.task 'template-cache', ['jade'], ->
    templateCacheConfigs = configs.templateCache.map (config) ->
      if config?.files
        src               = gulp.src config.files || defaultTemplateCacheConfig.files
        destPath          = config.destPath || defaultTemplateCacheConfig.destPath
        dest              = gulp.dest destPath
        fileName          = config.fileName || defaultTemplateCacheConfig.fileName
        minifyHtmlOptions = config.minifyHtml || {}

        options =
          root      : config.root
          module    : config.module
          standAlone: config.standAlone

        minifyHtml    = $.minifyHtml minifyHtmlOptions
        templateCache = $.angularTemplatecache fileName, options

        src.pipe(minifyHtml).pipe(templateCache).pipe(dest)

    eventStream.merge templateCacheConfigs
