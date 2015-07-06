defaultConstants =
  apiUrl          : 'https://api.topcoder-dev.com/v3/' # slash is grandfathered in, need to remove
  API_URL         : 'https://api.topcoder-dev.com/v3'
  API_URL_V2      : 'https://api.topcoder-dev.com/v2'
  AVATAR_URL      : 'http://www.topcoder.com'
  SUBMISSION_URL  : 'https://studio.topcoder.com'
  AUTH0_CLIENT_ID : 'abc123'
  AUTH0_DOMAIN    : 'topcoder-dev.auth0.com'
  AUTH0_TOKEN_NAME: 'userJWTToken'

module.exports = (gulp, $, configs) ->
  constants = {}

  for key, defaultConstant of defaultConstants
    envVal         = configs.env.getVal key
    constants[key] = configs.constants?[key] || envVal || defaultConstant

  gulp.task 'ng-constant', ->
    options =
      name     : 'app.constants'
      constants: constants
      stream   : true

    destPath = configs.tempFolder + '/scripts'

    dest = gulp.dest destPath

    $.ngConstant(options).pipe dest

