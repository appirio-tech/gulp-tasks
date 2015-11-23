styleguide = require('sc5-styleguide');

defaultStyleguideFiles = ['styles/**/*.scss']
defaultOutputDirectory = 'styleguide'
defaultMainSCSSFile    = 'main.scss'

module.exports = (gulp, $, configs) ->
  scssFiles             = configs.styleguideGenerator?.scssFiles || defaultStyleguideFiles
  generatorIncludePaths = configs.styleguideGenerator?.includePaths
  mainSCSSFile          = configs.styleguideGenerator?.mainSCSSFile || defaultMainSCSSFile
  styleguideOptions     = configs.styleguideGenerator?.options
  outputDirectory       = configs.styleguideGenerator?.options?.rootPath || defaultOutputDirectory

  gulp.task 'styleguide:generate', ->
    if !styleguideOptions
      red = $.util.colors.red 'Styleguide options are required to run this task.'
      $.util.beep()
      $.util.log red
      process.exit(1)

    generate = styleguide.generate styleguideOptions
    src      = gulp.src scssFiles
    dest     = gulp.dest outputDirectory

    src.pipe(generate).pipe dest

  gulp.task 'styleguide:applystyles', ->
    options =
      includePaths: generatorIncludePaths
      errLogToConsole: true

    scss        = $.sass options
    applyStyles = styleguide.applyStyles()
    src         = gulp.src mainSCSSFile
    dest        = gulp.dest outputDirectory

    src.pipe(scss).pipe(applyStyles).pipe dest

  gulp.task 'styleguide', ['styleguide:generate', 'styleguide:applystyles']

  gulp.task 'watch-styleguide', ['styleguide'], ->
    # Start watching changes and update styleguide whenever changes are detected
    gulp.watch scssFiles, ['styleguide']
