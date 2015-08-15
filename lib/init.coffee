LinterHandlebarsProvider = require './markdownlint-provider'


module.exports =

  activate: ->
    console.log "activate linter-node markdownlint" # if atom.inDevMode()

    if not atom.packages.getLoadedPackage 'linter'
      atom.notifications.addError """
        [linter-node markdownlint] `linter` package not found, please install it.
      """

  provideLinter: -> LinterHandlebarsProvider
