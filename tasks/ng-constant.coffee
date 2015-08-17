defaultNgConstants =
  API_URL                 : 'https://api.topcoder.com'
  AVATAR_URL              : 'https://www.topcoder.com'
  SUBMISSION_URL          : 'https://studio.topcoder.com'
  AUTH0_CLIENT_ID         : 'abc123'
  AUTH0_DOMAIN            : 'topcoder.auth0.com'
  AUTH0_TOKEN_NAME        : 'userJWTToken'
  AUTH0_REFRESH_TOKEN_NAME: 'userRefreshJWTToken'

defaultDestPath = '.tmp/scripts'

module.exports = (gulp, $, configs) ->
  destPath  = configs.ngConstants?.destPath || defaultDestPath
  constants = {}

  for key, defaultConstant of defaultNgConstants
    envVal         = configs.env.getVal key
    constants[key] = configs.ngConstants?.constants?[key] || envVal || defaultConstant

  gulp.task 'ng-constant', ->
    options =
      name     : 'app.constants'
      constants: constants
      stream   : true

    dest = gulp.dest destPath

    $.ngConstant(options).pipe dest

