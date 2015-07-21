'use strict'

describe 'Main', ->
  it 'should load swagger', ->
    expect(window.service).to.be.equal 'service'

  it 'should have jquery', ->
    expect($).to.be.ok