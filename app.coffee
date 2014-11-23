app = require './src/app'
port = process.env.PORT || 3000
app.listen port
console.log "Listening on #{port}"
