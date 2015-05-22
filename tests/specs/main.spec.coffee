'use strict'

describe 'Main', ->
  it 'should have a query method', ->
    expect(window.apiMock.greeting).to.be.equal 'Hello World!'