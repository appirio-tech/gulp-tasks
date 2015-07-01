karmaConfig =
  configFile  : __dirname + '/karma.conf.coffee'
  basePath    : __dirname
  coverage    : 'app/**/*.coffee'
  coffeeFiles : ['tests/specs/**/*.coffee'] # Dont include coverage files
  files: [
    'bower_components/jquery/dist/jquery.js'
    '.tmp/scripts/json-fixtures.js'
    'app/**/*.coffee'
    'tests/specs/**/*.coffee'
  ]

templateCache =
  files : [
    '.tmp/views/footer.html'
    '.tmp/views/main.html'
  ]
  root  : 'views/'
  module: 'appirio-tech-messaging'


configs =
  scssIncludePaths: require('node-neat').includePaths
  tempFolder      : '.tmp'
  appFolder       : 'app'
  distFolder      : 'dist'
  karma           : karmaConfig
  templateCache   : templateCache

### END CONFIG ###

gulp          = require 'gulp'
$             = require('gulp-load-plugins')()
$.browserSync = require 'browser-sync'
$.karma       = require('karma').server
configs.env   = require './config'

tasks = [
  'coffee'
  'jade'
  'scss'
  'clean'
  'serve'
  'build'
  'test'
  'ng-constant'
  'coveralls'
  'fixtures'
  'template-cache'
  'uglify'
  'minify-css'
  'cdnify'
  'finger-print'
  'finger-print-replace'
]

for task in tasks
  module = require('./tasks/' + task)
  module gulp, $, configs

gulp.task 'default', ['clean'], ->
  gulp.start 'build'

