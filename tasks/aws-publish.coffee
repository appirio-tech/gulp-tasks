defaultAwsPublishFiles = ['dist/**/*', '!dist/index.html']
defaultAwsPublishIndex = 'dist/index.html'
defaultDependencies    = []

module.exports = (gulp, $, configs) ->
  bucket       = configs.awsPublish?.bucket || configs.env.getVal 'AWS_BUCKET', ''
  key          = configs.awsPublish?.key || configs.env.getVal 'AWS_KEY', ''
  secret       = configs.awsPublish?.secret || configs.env.getVal 'AWS_SECRET', ''
  files        = configs.awsPublish?.files || configs.awsPublishFiles || defaultAwsPublishFiles
  index        = configs.awsPublish?.index || configs.awsPublishIndex || defaultAwsPublishIndex
  sync         = configs.awsPublish?.sync || false
  dependencies = configs.awsPublish?.dependencies || defaultDependencies

  gulp.task 'aws-publish', dependencies, ->
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
    sync         = $.if sync, publisher.sync()

    gulp.src(index).pipe(gzip).pipe(publishIndex).pipe(sync).pipe(reporter)

    # Publish all other files
    filesHeaders =
      'Cache-Control': 'max-age=315360000, no-transform, public'

    publishFiles = publisher.publish filesHeaders

    gulp.src(files).pipe(gzip).pipe(publishFiles).pipe(sync).pipe(reporter)