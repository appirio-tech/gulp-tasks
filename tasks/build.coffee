runSequence = require 'run-sequence'

module.exports = (gulp, $, configs) ->

  gulp.task 'build:topcoder', (done) ->
    # Build everything
    runSequence(
      'clean'
      ['optimize', 'fonts']
      'images:move-skills'
      done
    )

  gulp.task 'build-specs:topcoder', ['template-cache', 'ng-constant'], ->
    # Build the spec runner
    wiredep        = require('wiredep').stream;
    config         = configs.wiredep
    wiredepOptions = configs.wiredep.options || {}
    wiredepOptions.devDependencies = true

    src     = gulp.src config.specRunner
    dest    = gulp.dest './app/'
    wiredep = wiredep wiredepOptions

    src
      .pipe wiredep
      .pipe($.inject(gulp.src(config.testLibraries),
        {name: 'inject:testlibraries', read: false}))
      .pipe($.inject(gulp.src(config.nonBowerScripts),
        {name: 'inject:nonBowerScripts', read: false}))
      .pipe($.inject(
        gulp.src(config.js)
        .pipe($.naturalSort())
        .pipe($.angularFilesort())
      ))
      .pipe($.inject(gulp.src(config.specHelpers),
        {name: 'inject:spechelpers', read: false}))
      .pipe($.inject(gulp.src(config.specs),
        {name: 'inject:specs', read: false}))
      .pipe($.inject(gulp.src(config.templateCacheFile),
        {name: 'inject:templates', read: false}))
      .pipe dest


  dependencies = [
    'ng-constant'
    'fixtures'
    'template-cache'
    'scss'
    'coffee'
    'bower-images'
  ]

  gulp.task 'preprocessors', dependencies, ->
    # nothing

  ## DEPRECATED, DO NOT USE ##
  optimizeDependencies = [
    'cdnify'
    'uglify'
    'minify-css'
    'remove-code'
  ]

  gulp.task 'optimize-build', optimizeDependencies, ->
    # should run build before this

