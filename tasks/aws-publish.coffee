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
  bucket        = configs.awsPublish?.bucket || configs.env.getVal 'AWS_BUCKET', ''
  key           = configs.awsPublish?.key || configs.env.getVal 'AWS_KEY', ''
  secret        = configs.awsPublish?.secret || configs.env.getVal 'AWS_SECRET', ''
  files         = configs.awsPublish?.files || defaultAwsPublishFiles
  sync          = configs.awsPublish?.sync || false
  dependencies  = configs.awsPublish?.dependencies || defaultDependencies
  routerOptions = configs.awsPublish?.routerOptions || defaultRouterOptions

  gulp.task 'aws-publish', dependencies, ->
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