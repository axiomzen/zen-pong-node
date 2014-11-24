Game = require './gameModel'
Team = require './teamModel'
Player = require './playerModel'
gameCount = 1
currentGame = new Game(gameCount, 'singles')
winners = {}
socket = null

module.exports = (app, io) ->
  # Establish socket connection
  io.on 'connection', (s) ->
    socket = s
    console.log 'io connected!'
    socket.emit 'event', currentGame # initial data

  # Get current game info
  app.get '/game', (req, res) ->
    res.render 'game',
      game: currentGame

  # Login screen
  app.get '/login', (req, res) ->
    res.render 'login'

  # Join a game
  #   "name": String
  #   "team": 1 or 0
  app.post '/join', (req, res) ->
    if (not req.body.name?)
      res.json({ 'error': 'missing "name"'})
      return
    currentGame.addPlayer(req.body.name, req.body.team - 1) # account for base 0
    res.render 'join',
      name: req.body.name
    socket.emit 'event', currentGame # send updated data

  # Increment score
  #   "team": 1 or 0
  app.post '/score', (req, res) ->
    if (not req.body.team?)
      res.json({ 'error': 'missing "team"'})
      return
    if (not currentGame.isReady())
      res.json({ 'error': 'teams not ready'})
      return
    currentGame.increment(req.body.team - 1); # account for base 0
    if (currentGame.isOver())
      winnerIdx = currentGame.getWinner().getPlayerList()
      winners[winnerIdx] = { wins: 0, name: winnerIdx} if not winners[winnerIdx]?
      winners[winnerIdx].wins++
      currentGame = new Game(++gameCount, 'singles')
    res.json({ 'success': 'true'})
    socket.emit 'event', currentGame # send updated data

  # Show leaderboards
  app.get '/leaderboards', (req, res) ->
    leaderboard = {}
    winnerList = (k for k of winners)
    sortedWinners = winnerList.sort (a, b) -> winners[a] - winners[b]
    # res.json({'leaderboards': sortedWinners})
    leaderboard = (winners[name] for name in sortedWinners)
    console.log('winners', winners)
    console.log('sortedWinners', sortedWinners)
    console.log('leaderboard', leaderboard)
    res.json({'leaderboards': leaderboard})
