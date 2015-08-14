{ config } = require '../lib/init'


module.exports.resetConfig = ->

  Object.keys(config or {}).forEach (key) ->
    atom.config.set("linter-node-markdownlint.#{key}", config[key].default)
