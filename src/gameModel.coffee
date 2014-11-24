Team = require './teamModel'
Player = require './playerModel'

class Game
  NUM_TEAMS = 2
  MAX_SCORE = 11
  WIN_BY = 2

  constructor: (@name) ->
    @gameOver = false
    @winner = null
    @teams = []

  addPlayer: (playerName) ->
    @teams.push new Team(playerName)

  increment: (teamIdx) ->
    if (this.isOver())
      return
    @teams[teamIdx].increment()
    if (@teams[teamIdx].score is MAX_SCORE)
      opponentIdx = (teamIdx + 1) % NUM_TEAMS
      console.log('opponentIdx', opponentIdx)
      if (@teams[teamIdx].score >= @teams[opponentIdx].score + 2)
        @gameOver = true
        @winner = @teams[teamIdx]
        console.log('Team', @teams[teamIdx].name, 'wins!')

  isOver: ->
    return @gameOver

  getWinner: ->
    return @winner;

  isReady: ->
    ready = true
    # playerLimit = 1
    # for team in @teams
    #   ready = ready && team.isReady(playerLimit)
    return ready

module.exports = Game
