defaultAwsPublishFiles = 'dist/**/*'

module.exports = (gulp, $, configs) ->
  bucket = configs.env.getVal 'AWS_BUCKET', ''
  key    = configs.env.getVal 'AWS_KEY', ''
  secret = configs.env.getVal 'AWS_SECRET', ''
  files  = defaultAwsPublishFiles || configs.awsPublishFiles

  gulp.task 'aws-publish', ->
    options =
      bucket: bucket
      key   : key
      secret: secret

    headers =
      'Cache-Control': 'max-age=315360000, no-transform, public'

    publisher = $.awspublish.create options
    publish   = publisher.publish headers
    sync      = publisher.sync()
    reporter  = $.awspublish.reporter()
    src       = gulp.src files

    src.pipe(publish).pipe(sync).pipe reporter
