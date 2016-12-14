"use babel"

import path from  'path'
import markdownlint from  'markdownlint'
import helpers, { find } from 'atom-linter'
import rc from 'rc/lib/utils'
import fs from 'fs'
import links from './links'

function link(identifier) {
  return `https://github.com/mivok/markdownlint/blob/master/docs/RULES.md#${links[identifier]}`
}

export default {

  grammarScopes: [
    'source.gfm',
    'source.pfm',
    'text.html.markdown.source.gfm.apib'
  ],

  scope: 'file',

  lintOnFly: true,

  lint(textEditor) {

    return new Promise((resolve, reject) => {

      const bufferText = textEditor.getText()
      const filePath = textEditor.getPath()
      const options = {
        strings: { string: bufferText }
      }

      const configPath = find(filePath, '.markdownlintrc')

      if (!configPath && this.config('disableIfNoMarkdownlintrc')) {
        return resolve([])
      }

      if (configPath) {
        const configText = fs.readFileSync(configPath, 'utf8')
        options['config'] = rc.parse(configText)
      }

      markdownlint(options, (err, result) => {
        if (!err) {
          const errors = result.toString()
            .split(/\n/)
            .map((line) => line.match(/^string: (\d+): (MD\d+) (.*)$/))
            .filter((match) => match)
            .map((match) => ({
              type: 'Error',
              text: `${match[2]} ${match[3]}`,
              html: `<a href="${link(match[2])}">${match[2]}</a> ${match[3]}`,
              filePath: textEditor.getPath(),
              range: this.lineRange(match[1] - 1, bufferText),
            }))

          resolve(errors)
        }
      })
    })
  },

  lineRange(lineIdx, bufferText) {

    const line = bufferText.split(/\n/)[lineIdx] || ''
    const pre = String(line.match(/^\s*/))

    return [[lineIdx, pre.length], [lineIdx, line.length]]
  },

  config(key) {
    return atom.config.get(`linter-node-markdownlint.${key}`)
  }
}
