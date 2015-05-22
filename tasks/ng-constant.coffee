module.exports = (gulp, $, configs) ->
  gulp.task 'ng-constant', ->
    options =
      name     : 'app.constants'
      constants: configs.constants
      stream   : true

    destPath = configs.tempFolder + '/scripts'

    dest = gulp.dest destPath

    $.ngConstant(options).pipe dest

