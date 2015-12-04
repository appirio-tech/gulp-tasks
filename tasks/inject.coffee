module.exports = (gulp, $, configs) ->
  gulp.task 'wiredep', ['jade'], ->
    # Injects bower css/js and app js files into index.jade
    wiredep        = require('wiredep').stream;
    config         = configs.wiredep
    wiredepOptions = configs.wiredep.options || {}

    src     = gulp.src config.index
    wiredep = wiredep wiredepOptions
    dest    = gulp.dest config.destPath

    injectAppJS = $.inject(
      gulp.src(config.js)
      .pipe($.naturalSort('desc'))
      .pipe($.angularFilesort()), {relative: true})

    injectNonBowerJS = $.inject(
      gulp.src(config.nonBowerScripts, {read: false}), {
      starttag: '//- inject:nonBowerScripts',
      endtag: '//- endinject',
      ignorePath: 'assets/'})

    src.pipe(wiredep).pipe(injectAppJS).pipe(injectNonBowerJS).pipe dest

  gulp.task 'inject', ['wiredep', 'scss', 'template-cache'], ->
    # Injects app css into index.jade
    config = configs.wiredep

    src  = gulp.src config.index
    dest = gulp.dest config.destPath

    injectAppCSS = $.inject( # Sort the css (topcoder.css, then everything else)
        gulp.src(config.css, {read: false})
        .pipe($.naturalSort('desc')),
        {ignorePath: '.tmp', addRootSlash: false})

    src.pipe(injectAppCSS).pipe dest
