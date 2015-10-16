defaultAwsPublishFiles = ['dist/**/*', '!dist/index.html']
defaultAwsPublishIndex = 'dist/index.html'

module.exports = (gulp, $, configs) ->
  bucket = configs.env.getVal 'AWS_BUCKET', ''
  key    = configs.env.getVal 'AWS_KEY', ''
  secret = configs.env.getVal 'AWS_SECRET', ''
  files  = configs.awsPublishFiles || defaultAwsPublishFiles
  index  = configs.awsPublishIndex || defaultAwsPublishIndex

  gulp.task 'aws-publish', ->
    options =
      accessKeyId    : key
      secretAccessKey: secret
      params:
        Bucket: bucket

    gzip      = $.awspublish.gzip()
    reporter  = $.awspublish.reporter()
    publisher = $.awspublish.create options

    # Publish index
    indexHeaders =
      'Cache-Control': 'private, no-store, no-cache, must-revalidate, max-age=0'

    publishIndex = publisher.publish indexHeaders

    gulp.src(index).pipe(gzip).pipe(publishIndex).pipe(reporter)

    # Publish all other files
    filesHeaders =
      'Cache-Control': 'max-age=315360000, no-transform, public'

    publishFiles = publisher.publish filesHeaders

    gulp.src(files).pipe(gzip).pipe(publishFiles).pipe(reporter)