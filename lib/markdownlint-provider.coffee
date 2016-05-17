path = require 'path'
markdownlint = require 'markdownlint'
{find} = helpers = require 'atom-linter'
rc = require('rc/lib/utils')
fs = require('fs')

module.exports =

  grammarScopes: ['source.gfm', 'source.pfm']

  scope: 'file'

  lintOnFly: true

  lint: (textEditor) ->

    return new Promise (resolve, reject) =>

      bufferText = textEditor.getText()

      filePath = textEditor.getPath()

      options = {
        "strings": { "string": bufferText }
      }

      configPath = find filePath, '.markdownlintrc'
      
      if not configPath and this.config 'disableIfNoMarkdownlintrc'
        return resolve []

      if configPath
        configText = fs.readFileSync(configPath, 'utf8')
        options['config'] = rc.parse(configText)

      markdownlint options, (err, result) =>
        unless err
          errors = result.toString()
            .split /\n/
            .map (line) -> line.match /^string: (\d+): (.*)$/
            .filter (match) -> match
            .map (match) => {
              type: 'Error'
              text: match[2]
              filePath: textEditor.getPath()
              range: @lineRange match[1] - 1, bufferText
            }

          resolve(errors)
  
  lineRange: (lineIdx, bufferText) ->

    line = bufferText.split(/\n/)[lineIdx] or ''
    pre = String line.match /^\s*/

    return [[lineIdx, pre.length], [lineIdx, line.length]]

  config: (key) ->
    atom.config.get "linter-node-markdownlint.#{key}"
