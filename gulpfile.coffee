gulp          = require 'gulp'
$             = require('gulp-load-plugins')()
$.browserSync = require 'browser-sync'
$.karma       = require('karma').server

karmaFiles = [
  'bower_components/jquery/dist/jquery.js'
  '.tmp/scripts/json-fixtures.js'
  'app/scripts/**/*.coffee'
  'tests/specs/**/*.coffee'
]

fixtureFiles = [
  'app/**/*.json'
]

configs =
  coffeeFiles   : 'app/**/*.coffee'
  jadeFiles     : 'app/**/*.jade'
  scssFiles     : 'app/**/*.scss'
  specFiles     : 'tests/specs/**/*.coffee'
  tempFolder    : '.tmp'
  appFolder     : 'app'
  distFolder    : 'dist'
  karmaFiles    : karmaFiles
  fixtureFiles  : fixtureFiles
  karmaConfig   : __dirname + '/karma.conf.coffee'
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

