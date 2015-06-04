gulp          = require 'gulp'
$             = require('gulp-load-plugins')()
$.browserSync = require 'browser-sync'
$.karma       = require('karma').server

karmaConfig =
  configFile  : __dirname + '/karma.conf.coffee'
  coverage    : 'app/**/*.coffee'
  coffeeFiles : ['tests/specs/**/*.coffee'] # Dont include coverage files
  files: [
    'bower_components/jquery/dist/jquery.js'
    '.tmp/scripts/json-fixtures.js'
    'app/**/*.coffee'
    'tests/specs/**/*.coffee'
  ]

fixtureFiles = [
  'app/**/*.json'
]

buildFiles =
  copy: ['.tmp/index.html']
  concat:
    'main.js': ['.tmp/scripts/main.js', 'app/scripts/test.js']
    'main.css': ['.tmp/styles/main.css', 'app/styles/test.css']

configs =
  coffeeFiles     : 'app/**/*.coffee'
  jadeFiles       : 'app/**/*.jade'
  scssFiles       : 'app/**/*.scss'
  scssIncludePaths: require('node-neat').includePaths
  tempFolder      : '.tmp'
  appFolder       : 'app'
  distFolder      : 'dist'
  karma           : karmaConfig
  fixtureFiles    : fixtureFiles
  buildFiles      : buildFiles
  coverageReporter:
    type: 'lcov'
    dir: 'coverage'

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
]

for task in tasks
  module = require('./tasks/' + task)
  module gulp, $, configs

gulp.task 'default', ['clean'], ->
  gulp.start 'build'

