expect = require('chai').expect
request = require 'supertest'

app = require '../src/app'

describe 'Join a game | ', ->
  it 'should join a game', (done) ->
    request(app).post('/join')
      .send name: 'mck-'
      .expect(200, done)
