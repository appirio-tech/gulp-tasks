# Karma configuration
# http://karma-runner.github.io/0.12/config/configuration-file.html
# Generated on 2014-07-11 using
# generator-karma 0.8.3

module.exports = (config) ->

  config.set
    # base path, that will be used to resolve files and exclude
    basePath: './'

    # testing framework to use (jasmine/mocha/qunit/...)
    frameworks: ['mocha', 'chai', 'sinon']

    # list of files / patterns to exclude
    exclude: []

    # web server port
    port: 8080

    # level of logging
    # possible values: LOG_DISABLE || LOG_ERROR || LOG_WARN || LOG_INFO || LOG_DEBUG
    logLevel: config.LOG_INFO

    # Start these browsers, currently available:
    # - Chrome
    # - ChromeCanary
    # - Firefox
    # - Opera
    # - Safari (only Mac)
    # - PhantomJS
    # - IE (only Windows)
    browsers: [
      'PhantomJS'
    ]

    # enable / disable watching file and executing tests whenever any file changes
    autoWatch: true

    # Continuous Integration mode
    # if true, it capture browsers, run tests and exit
    singleRun: true

    colors: true

    reporters: ['progress', 'coverage']

    coffeePreprocessor:
      options:
        bare: false
        sourceMap: false
      transformPath: (path) ->
        path.replace(/\.coffee$/, '.js')

    # Uncomment the following lines if you are using grunt's server to run the tests
    proxies: '/base/.tmp': 'http://localhost:9000'
    # URL root prevent conflicts with the site root
    # urlRoot: '_karma_'
