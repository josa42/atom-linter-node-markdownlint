"use babel"

import markdownlint from  'markdownlint'
import { find } from 'atom-linter'
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
    'text.html.markdown.source.gfm.apib',
    'text.md'
  ],

  scope: 'file',

  lintOnFly: true,

  lint(textEditor) {

    return new Promise((resolve) => {

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
          resolve(
            result.string.map(({ lineNumber, ruleNames: [rule], ruleDescription }) => ({
              name: "markdownlint",
              type: 'Error',
              html: `<a href="${link(rule)}">${rule}</a> ${ruleDescription}`,
              filePath: textEditor.getPath(),
              range: this.lineRange(lineNumber - 1, bufferText),
            }))
          )
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
