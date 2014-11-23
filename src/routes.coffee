module.exports = (app) ->
  # Join a game
  app.post '/join', (req,res) ->
    res.send('joining...')
