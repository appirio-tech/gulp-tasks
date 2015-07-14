# gulp-tasks
[![Build Status](https://travis-ci.org/appirio-tech/gulp-tasks.svg?branch=master)](https://travis-ci.org/appirio-tech/gulp-tasks)
[![Coverage Status](https://coveralls.io/repos/appirio-tech/gulp-tasks/badge.svg)](https://coveralls.io/r/appirio-tech/gulp-tasks)

## Useful alias
```
alias gserve='nvm use; gulp clean; gulp serve'
alias gtest='nvm use; gulp test'
alias gtestserve='nvm use; gulp test-serve'
alias gbuild='nvm use; gulp clean; gulp preprocessors; gulp useref; gulp copy-files;'
```

## Releases
Since npm does not support semvers, we use branches name accordingly, e.g. 1.x.x and 2.x.x.  Simply merge or rebase into those branches for a release.
