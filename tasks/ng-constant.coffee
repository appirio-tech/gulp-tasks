module.exports = (gulp, $, configs) ->
  gulp.task 'ng-constant', ->
    if configs.constants
      options =
        name     : 'app.constants'
        constants: configs.constants
        stream   : true

      destPath = configs.tempFolder + '/scripts'

      dest = gulp.dest destPath

      $.ngConstant(options).pipe dest

