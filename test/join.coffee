expect = require('chai').expect
request = require 'supertest'

app = require '../src/app'

describe 'Join a game | ', ->
  it 'should join a game', (done) ->
    request(app).post('/join')
      .send name: 'mck-'
      .expect(200, done)

  it 'should get the current game', (done) ->
    request(app).get('/game')
      .expect(200)
      .end (err, res) ->
        done err if err
        expect(res.body.players).to.be.an 'Array'
        expect(res.body.players[0].name).to.equal 'mck-'
        expect(res.body.players[0].score).to.equal 0
        done()
