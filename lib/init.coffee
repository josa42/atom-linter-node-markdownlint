LinterHandlebarsProvider = require './markdownlint-provider'
{ install } = require 'atom-package-deps'

module.exports =

  activate: ->
    install 'linter-node-markdownlint' unless atom.inSpecMode()

  provideLinter: -> LinterHandlebarsProvider
