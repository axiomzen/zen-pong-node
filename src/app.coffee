express = require 'express'
app = express()
bodyParser = require 'body-parser'
path = require("path")
app.use bodyParser.json()

app.set "views", path.join(__dirname, "views")
app.set "view engine", "jade"

require('./routes')(app)
module.exports = app
