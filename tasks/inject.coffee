module.exports = (gulp, $, configs) ->
  gulp.task 'wiredep', ['jade'], ->
    # Injects bower css/js and app js files into index.jade
    wiredepOptions = configs.wiredep.options
    options        = configs.wiredep
    wiredep        = require('wiredep').stream;

    src     = gulp.src options.index
    wiredep = wiredep wiredepOptions
    dest    = gulp.dest options.destPath

    injectAppJS = $.inject(
      gulp.src(options.js)
      .pipe($.naturalSort('desc'))
      .pipe($.angularFilesort()), {relative: true})

    injectNonBowerJS = $.inject(
      gulp.src(options.nonBowerScripts, {read: false}), {
      starttag: '//- inject:nonBowerScripts',
      endtag: '//- endinject',
      ignorePath: 'assets/'})


    src.pipe(wiredep).pipe(injectJS).pipe(injectNonBowerJS).pipe dest

  gulp.task 'inject', ['wiredep', 'scss', 'template-cache'], ->
    # Injects app css into index.jade
    src  = gulp.src options.index
    dest = gulp.dest options.destPath

    injectAppCSS = $.inject( # Sort the css (topcoder.css, then everything else)
        gulp.src(options.css, {read: false})
        .pipe($.naturalSort('desc')),
        {ignorePath: '.tmp', addRootSlash: false})

    src.pipe(injectAppCSS).pipe dest
