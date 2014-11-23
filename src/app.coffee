express = require 'express'
app = express()
bodyParser = require 'body-parser'
app.use bodyParser.json()
require('./routes')(app)
module.exports = app
