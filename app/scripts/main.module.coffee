'use strict'

window.apiMock = FIXTURES['bower_components/appirio-tech-api-schemas/swagger/v3-messages.json']

$('main').html apiMock.greeting

window.angular =
  module =
    module: ->
      run: ->
        console.log 'run'
      constant: ->
        this
