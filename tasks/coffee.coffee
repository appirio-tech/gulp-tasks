defaultCoffeeFiles = [
  'app/**/*.coffee'
  'example/**/*.coffee'
  'src/**/*.coffee'
]
defaultTempFolder  = '.tmp'

module.exports = (gulp, $, configs) ->
  coffeeFiles = configs.coffee?.files || defaultCoffeeFiles
  tempFolder  = configs.coffee?.tempFolder || defaultTempFolder

  gulp.task 'coffee', ->
    onError = ->
      red = $.util.colors.red 'Coffee error'
      $.util.beep()
      $.util.log red
      console.log arguments

    coffee  = $.cjsx bare: false
    plumber = $.plumber errorHandler: onError
    src     = gulp.src coffeeFiles
    dest    = gulp.dest tempFolder

    src.pipe(plumber).pipe(coffee).pipe dest