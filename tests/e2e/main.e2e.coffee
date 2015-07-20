h1Text = null

describe 'login', ->
  beforeEach (done) ->
    browser.get 'http://localhost:9000'

    $('h1').getText().then (value) ->
      h1Text = value

      done()

  it 'should have batman in header', ->
    expect(h1Text).to.be.equal 'Batman!!!'
