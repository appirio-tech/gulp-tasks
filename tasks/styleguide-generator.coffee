styleguide = require('sc5-styleguide');
argv       = require('yargs').argv

defaultStyleguideOptions =
  options:
    title: 'My Styleguide'
    server: true
    port: 3000
    rootPath: 'styleguide'

  scssFiles: ['styles/**/*.scss']

  mainSCSSFile: 'main.scss'

module.exports = (gulp, $, configs) ->
  if argv.team && configs.styleguideGenerator
    styleguideOptions = configs.styleguideGenerator[argv.team]
  else
    styleguideOptions = defaultStyleguideOptions

  generatorIncludePaths = configs.styleguideGenerator?.includePaths

  gulp.task 'styleguide:generate', ->
    generate = styleguide.generate styleguideOptions.options
    src      = gulp.src styleguideOptions.scssFiles
    dest     = gulp.dest styleguideOptions.options.rootPath

    src.pipe(generate).pipe dest

  gulp.task 'styleguide:applystyles', ->
    options =
      includePaths: generatorIncludePaths
      errLogToConsole: true

    scss        = $.sass options
    applyStyles = styleguide.applyStyles()
    src         = gulp.src styleguideOptions.mainSCSSFile
    dest        = gulp.dest styleguideOptions.options.rootPath

    src.pipe(scss).pipe(applyStyles).pipe dest

  gulp.task 'styleguide', ['styleguide:generate', 'styleguide:applystyles']

  gulp.task 'watch-styleguide', ['styleguide'], ->
    # Start watching changes and update styleguide whenever changes are detected
    watchFiles = defaultStyleguideOptions.scssFiles

    if argv.team && configs.styleguideGenerator
      watchFiles = configs.styleguideGenerator[argv.team].scssFiles

    gulp.watch watchFiles, ['styleguide']
