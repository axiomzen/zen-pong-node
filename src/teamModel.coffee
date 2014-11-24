Player = require './playerModel'

class Team
  constructor: (@name) ->
    @score = 0
    @players = []

  addPlayer: (playerName, playerLimit) ->
    if (@players.length < playerLimit)
      @players.push new Player(playerName)
      console.log('Player', playerName, 'added')
    else
      console.log('Cannot add player', playerName, 'limit reached');

  increment: ->
    @score++
    console.log('Team', @name, 'score', @score)

  getPlayerList: ->
    return (player.name for player in @players)

  isReady: (playerLimit) ->
    return @players.length is playerLimit

module.exports = Team
