defaultAwsPublishFiles = 'dist/**/*'

module.exports = (gulp, $, configs) ->
  bucket = configs.env.getVal 'AWS_BUCKET', ''
  key    = configs.env.getVal 'AWS_KEY', ''
  secret = configs.env.getVal 'AWS_SECRET', ''
  files  = configs.awsPublishFiles || defaultAwsPublishFiles

  gulp.task 'aws-publish', ->
    options =
      accessKeyId    : key
      secretAccessKey: secret
      params:
        Bucket: bucket

    gzipOptions =
      ext: '.gz'

    headers =
      'Cache-Control': 'max-age=315360000, no-transform, public'

    publisher    = $.awspublish.create options
    publishCache = publisher.cache()
    gzip         = $.awspublish.gzip gzipOptions
    publish      = publisher.publish headers
    sync         = publisher.sync()
    reporter     = $.awspublish.reporter()
    src          = gulp.src files

    src.pipe(publish).pipe(gzip).pipe(publishCache).pipe(sync).pipe reporter
