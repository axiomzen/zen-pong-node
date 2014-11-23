module.exports = (io) ->
  io.on 'connection', (socket) ->
    console.log 'io connected!'
    socket.emit 'score', 'hello'
