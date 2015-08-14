path = require 'path'
markdownlint = require 'markdownlint'

module.exports =

  grammarScopes: ['source.gfm', 'source.pfm']

  scope: 'file'

  lintOnFly: true

  lint: (textEditor) ->

    return new Promise (resolve, reject) =>

      bufferText = textEditor.getText()

      options = {
        "strings": { "string": bufferText }
      }

      markdownlint options, (err, result) =>
        unless err
          errors = result.toString()
            .split /\n/
            .map (line) -> line.match /^string: (\d+): (.*)$/
            .filter (match) -> match
            .map (match) =>
              return {
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
