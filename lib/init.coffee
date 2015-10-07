LinterHandlebarsProvider = require './markdownlint-provider'
packageDeps = require 'atom-package-deps'

module.exports =

  activate: ->
    console.log "activate linter-node markdownlint" if atom.inDevMode()

    packageDeps.install 'linter-node markdownlint'

  provideLinter: -> LinterHandlebarsProvider
