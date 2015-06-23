defaultCoffeeFiles = 'app/**/*.coffee'
defaultTempFolder  = '.tmp'

module.exports = (gulp, $, configs) ->
  coffeeFiles = defaultCoffeeFiles || configs.coffeeFiles
  tempFolder  = configs.tempFolder || defaultTempFolder

  gulp.task 'coffee', ->
    onError = ->
      red = $.util.colors.red 'Coffee error'
      $.util.beep()
      $.util.log red
      console.log arguments

    coffee  = $.coffee bare: false
    plumber = $.plumber errorHandler: onError
    src     = gulp.src coffeeFiles
    dest    = gulp.dest tempFolder

    src.pipe(plumber).pipe(coffee).pipe dest