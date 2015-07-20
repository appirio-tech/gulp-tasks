require('coffee-script').register();

exports.config = {
  // The file path to the selenium server jar.
  framework: 'mocha',
  onPrepare: function () {
    global.chai    = require('chai');
    global.expect  = chai.expect;
    global.By      = global.by;
    global.http    = require('http');
    global.express = require('express');
  },
  mochaOpts: {
    ui: 'bdd',
    reporter: 'list',
    timeout: 180000
  }
};