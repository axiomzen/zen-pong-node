Player = require './playerModel'
players = []

module.exports = (app) ->

  # Get current game info
  app.get '/game', (req, res) ->
    res.send players: players

  # Login screen
  app.get '/login', (req, res) ->
    res.render 'login'

  # Join a game
  app.post '/join', (req, res) ->
    players.push new Player(req.body.name)
    res.render 'join',
      name: req.body.name

  # Increment score
  app.post '/score', (req, res) ->
    player = players[parseInt(req.body.player) - 1] # account for base 0
    res.json(++player.score)
