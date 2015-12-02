RevAll = require('gulp-rev-all');
merge  = require('merge-stream');

defaultUserefOptions     = searchPath: ['.tmp', 'app', 'assets']
defaultTemplateCacheFile = '.tmp/templates.js'
defaultIndexHTML         = '.tmp/index.html'
defaultDestPath          = './build'

module.exports = (gulp, $, configs) ->
  userefOptions     = configs.optimize?.userefSOptions || defaultUserefOptions
  templateCacheFile = configs.optimize?.templateCacheFile || defaultTemplateCacheFile
  indexHTML         = configs.optimize?.indexHTML || defaultIndexHTML
  writeSourceMaps   = configs.optimize?.writeSourceMaps || false
  assetPrefix       = configs.optimize?.assetPrefix || undefined
  destPath          = configs.optimize?.destPath || defaultDestPath

  # gulp.task 'optimize', ['inject', 'test', 'ng-constant', 'images'], ->
  gulp.task 'optimize', ['inject', 'ng-constant', 'images'], ->
    # Optimizing the JavaScript, CSS, and HTML
    assets      = $.useref.assets userefOptions
    cssFilter   = $.filter '**/*.css'
    jsLibFilter = $.filter '**/vendor.js'
    jsAppFilter = $.filter '**/app.js'

    imageStream  = gulp.src '.tmp/**/*.{svg,png,jpg,jpeg,gif}'
    userefStream = gulp.src indexHTML
      .pipe $.plumber()
      .pipe($.inject(gulp.src(templateCacheFile, {read: false}), {
        starttag: '<!-- inject:templates.js -->',
        endtag: '<!-- endinject -->',
        relative: true
      }))
      .pipe assets
      .pipe cssFilter
      .pipe $.csso()
      .pipe cssFilter.restore()
      .pipe jsLibFilter
      .pipe $.uglify()
      .pipe jsLibFilter.restore()
      .pipe jsAppFilter
      .pipe $.if(writeSourceMaps, $.sourcemaps.init())
      .pipe $.ngAnnotate()
      .pipe $.uglify()
      .pipe jsAppFilter.restore()
      .pipe assets.restore()
      .pipe $.useref()

    revAllOptions =
      prefix: assetPrefix
      dontRenameFile: [/^\/index.html/g]

    revAll = new RevAll(revAllOptions)

    merge(userefStream, imageStream)
      .pipe revAll.revision()
      .pipe $.if(writeSourceMaps, $.sourcemaps.write())
      # Uncomment if you want to see the JSON file containing
      # the file mapping (e.g., "{"js/app.js": "js/app-a9bae026bc.js"}")
      # .pipe gulp.dest('./build')
      # .pipe revAll.manifestFile()
      .pipe gulp.dest(destPath)
