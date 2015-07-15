# gulp-tasks
[![Build Status](https://travis-ci.org/appirio-tech/gulp-tasks.svg?branch=master)](https://travis-ci.org/appirio-tech/gulp-tasks)
[![Coverage Status](https://coveralls.io/repos/appirio-tech/gulp-tasks/badge.svg)](https://coveralls.io/r/appirio-tech/gulp-tasks)

## Sample gulp file
``` coffeescript
'use strict'

configs =
  __dirname: __dirname # required

configs.templateCache =
  files : [
    '.tmp/views/footer.html'
    '.tmp/views/main.html'
  ]
  root  : 'views/'
  module: 'appirio-tech-messaging'

loadTasksModule = require './load-tasks.coffee'

loadTasksModule.loadTasks configs
```

## Tasks
### `clean`

Delete folders
##### configs.cleanFiles
Gulp paths to clean. Default: `'.tmp', 'dist', 'coverage'`

### `cdnify`

Replace urls with a cdn url.
##### configs.cdnify.files
Files to use. Default: `'dist/**/*.css', 'dist/**/*.html'`

##### configs.cdnify.distPath
Where new files will be placed. Default: `dist`

### `coffee`

Convert coffee files to js files.
##### configs.coffee.files
Files to use. Default: `'app/**/*.coffee', 'example/**/*.coffee', 'src/**/*.coffee'`

##### configs.coffee.tempFolder
Where new files will be placed. Default: `.tmp`

### `copy`

Copy files to a location.
##### configs.copyFiles.files
Files to use. Default: `'dist': '**/*.{gif,png,jpg,jpeg,svg}'`

##### configs.copyFiles.base
Option passed to copy-files module. Default: `app/`

## Useful alias
```
alias gserve='nvm use; gulp clean; gulp serve'
alias gtest='nvm use; gulp test'
alias gtestserve='nvm use; gulp test-serve'
alias gbuild='nvm use; gulp clean; gulp preprocessors; gulp useref; gulp copy-files;'
```

## Releases
Since npm does not support semvers, we use branches name accordingly, e.g. 1.x.x and 2.x.x.  Simply merge or rebase into those branches for a release.
