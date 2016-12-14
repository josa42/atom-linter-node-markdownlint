"use babel"

import LinterHandlebarsProvider from './markdownlint-provider'
import config from './config'
import { install } from 'atom-package-deps'

export default {

  config,

  activate() {
    if (!atom.inSpecMode()) {
      install('linter-node-markdownlint')
    }
  },

  provideLinter: () => LinterHandlebarsProvider
}
