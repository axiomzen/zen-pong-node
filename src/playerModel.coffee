class Player
  constructor: (@name) ->
    @score = 0

  increment: ->
    @score++

module.exports = Player
