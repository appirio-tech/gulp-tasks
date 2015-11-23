styleguide = require('sc5-styleguide');

defaultStyleguideOptions =
  options:
    title: 'My Styleguide'
    server: true
    port: 3000
    rootPath: 'styleguide'

  scssFiles: ['styles/**/*.scss']

  mainSCSSFile: 'main.scss'

module.exports = (gulp, $, configs) ->
  styleguideOptions     = configs.styleguideGenerator || defaultStyleguideOptions
  generatorIncludePaths = configs.styleguideGenerator?.includePaths

  gulp.task 'styleguide:generate', ->
    for styleguideConfig in styleguideOptions
      generate = styleguide.generate styleguideConfig.options
      src      = gulp.src styleguideConfig.scssFiles
      dest     = gulp.dest styleguideConfig.options.rootPath

      src.pipe(generate).pipe dest

  gulp.task 'styleguide:applystyles', ->
    options =
      includePaths: generatorIncludePaths
      errLogToConsole: true

    for styleguideConfig in styleguideOptions
      scss        = $.sass options
      applyStyles = styleguide.applyStyles()
      src         = gulp.src styleguideConfig.mainSCSSFile
      dest        = gulp.dest styleguideConfig.options.rootPath

      src.pipe(scss).pipe(applyStyles).pipe dest

  gulp.task 'styleguide', ['styleguide:generate', 'styleguide:applystyles']

  gulp.task 'watch-styleguide', ['styleguide'], ->
    # Start watching changes and update styleguide whenever changes are detected
    # Not currently wired up to watch more than one directory/generated styleguide
    gulp.watch defaultStyleguideOptions.scssFiles, ['styleguide']
