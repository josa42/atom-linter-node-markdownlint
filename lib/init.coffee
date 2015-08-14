LinterHandlebarsProvider = require './markdonwlint-provider'


module.exports =

  activate: ->
    console.log "activate linter-node markdonwlint" # if atom.inDevMode()

    if not atom.packages.getLoadedPackage 'linter'
      atom.notifications.addError """
        [linter-node markdonwlint] `linter` package not found, please install it.
      """

  provideLinter: -> LinterHandlebarsProvider
