Player = require './playerModel'
players = []

module.exports = (app) ->

  # Get current game info
  app.get '/game', (req, res) ->
    res.send players: players

  # Join a game
  app.post '/join', (req, res) ->
    players.push new Player(req.body.name)
    res.send("joining as #{req.body.name}...")

  # Increment score
  app.post '/score', (req, res) ->
    console.log req.body
    player = players[req.body.player - 1] # account for base 0
    console.log player
    res.json(++player.score)
