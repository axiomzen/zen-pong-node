Player = require './playerModel'
players = []
socket = null

module.exports = (app, io) ->
  # Establish socket connection
  io.on 'connection', (s) ->
    socket = s
    console.log 'io connected!'
    socket.emit 'event', players # initial data

  # Get current game info
  app.get '/game', (req, res) ->
    res.render 'game',
      players: players

  # Login screen
  app.get '/login', (req, res) ->
    res.render 'login'

  # Join a game
  app.post '/join', (req, res) ->
    players.push new Player(req.body.name)
    res.send("joining as #{req.body.name}...")
    socket.emit 'event', players # send updated data

  # Increment score
  app.post '/score', (req, res) ->
    player = players[parseInt(req.body.player) - 1] # account for base 0
    res.json(++player.score)
    socket.emit 'event', players # send updated data
