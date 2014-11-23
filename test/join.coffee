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

  it 'should join another player', (done) ->
    request(app).post('/join')
      .send name: 'aidha'
      .expect(200, done)

  it 'should have 2 players', (done) ->
    request(app).get('/game')
      .expect(200)
      .end (err, res) ->
        done err if err
        expect(res.body.players).to.have.length 2
        expect(res.body.players[0].name).to.equal 'mck-'
        expect(res.body.players[1].name).to.equal 'aidha'
        done()

  it 'should increment score for player 1', (done) ->
    request(app).put('/score')
      .send player: 1
      .expect(200, done)

  it 'should increment score for player 1 again', (done) ->
    request(app).put('/score')
      .send player: 1
      .expect(200, done)

  it 'should increment score for player 2', (done) ->
    request(app).put('/score')
      .send player: 2
      .expect(200, done)

  it 'should be 2-1', (done) ->
    request(app).get('/game')
      .expect(200)
      .end (err, res) ->
        done err if err
        expect(res.body.players[0].score).to.equal 2
        expect(res.body.players[1].score).to.equal 1
        done()
