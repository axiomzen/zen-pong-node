Team = require './teamModel'
Player = require './playerModel'

class Game
  NUM_TEAMS = 2
  MAX_SCORE = 11
  WIN_BY = 2
  GAME_TYPE = {
    singles: {
      teamSize: 1
    },
    doubles: {
      teamSize: 2
    }
  }

  constructor: (@name, type) ->
    @score = 0
    @gameOver = false
    @winner = null
    @teams = []
    @teams.push new Team(1)
    @teams.push new Team(2)
    if (type of GAME_TYPE)
      @type = type
    else
      @type = 'singles'

  addPlayer: (playerName, teamIdx) ->
    playerLimit = GAME_TYPE[@type].teamSize;
    console.log('@teams[teamIdx]', @teams[teamIdx])
    @teams[teamIdx].addPlayer(playerName, playerLimit)

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
    playerLimit = GAME_TYPE[@type].teamSize;
    for team in @teams
      ready = ready && team.isReady(playerLimit)
    return ready

module.exports = Game
