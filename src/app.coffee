express = require 'express'
app = express()
require('./routes')(app)
module.exports = app
