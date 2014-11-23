Player = require './playerModel'
players = []

module.exports = (app) ->

  # Join a game
  app.post '/join', (req,res) ->
    players.push new Player(req.body.name)
    res.send('joining...')

  app.get '/game', (req,res) ->
    res.send players: players
