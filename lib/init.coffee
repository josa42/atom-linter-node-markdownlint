LinterHandlebarsProvider = require './markdownlint-provider'
config = require './config'
{ install } = require 'atom-package-deps'

module.exports =
  
  config: config

  activate: ->
    install 'linter-node-markdownlint' unless atom.inSpecMode()

  provideLinter: -> LinterHandlebarsProvider
