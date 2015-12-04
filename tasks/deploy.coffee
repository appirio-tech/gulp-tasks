merge = require 'merge-stream'

defaultAwsPublishFiles = ['build/**/*']
defaultDependencies    = []
defaultRouterOptions   =
  cache:
    cacheTime: 94608000
    allowTransform: false
    public: true
  routes:
    '^.+\\.html':
      cacheTime: 0
    '^.+$': '$&'

module.exports = (gulp, $, configs) ->
  bucket        = configs.deploy?.bucket || configs.env.getVal 'AWS_BUCKET', ''
  key           = configs.deploy?.key || configs.env.getVal 'AWS_KEY', ''
  secret        = configs.deploy?.secret || configs.env.getVal 'AWS_SECRET', ''
  files         = configs.deploy?.files || defaultAwsPublishFiles
  sync          = configs.deploy?.sync || false
  dependencies  = configs.deploy?.dependencies || defaultDependencies
  routerOptions = configs.deploy?.routerOptions || defaultRouterOptions

  gulp.task 'deploy', dependencies, ->
    options =
      accessKeyId    : key
      secretAccessKey: secret
      params:
        Bucket: bucket

    publisher = $.awspublish.create options
    reporter  = $.awspublish.reporter()
    sync      = $.if sync, publisher.sync()
    cache     = publisher.cache()
    gzip      = $.awspublish.gzip()
    src       = gulp.src files
    router    = $.awspublishRouter routerOptions
    publish   = publisher.publish()

    src
      .pipe gzip
      .pipe router
      .pipe cache
      .pipe publish
      .pipe sync
      .pipe reporter