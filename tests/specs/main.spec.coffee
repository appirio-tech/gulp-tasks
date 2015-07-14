'use strict'

describe 'Main', ->
  it 'should load swagger', ->
    expect(window.apiMock.swagger).to.be.equal '2.0'

  it 'should have jquery', ->
    expect($).to.be.ok