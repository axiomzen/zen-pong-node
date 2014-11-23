express = require 'express'
app = express()
bodyParser = require 'body-parser'
path = require("path")
app.use bodyParser.json()
app.use bodyParser.urlencoded()
app.use bodyParser.text()
app.use bodyParser.raw()
app.use express.static(__dirname + '/public')


app.set "views", path.join(__dirname, "views")
app.set "view engine", "jade"

require('./routes')(app)
module.exports = app
