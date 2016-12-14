"use babel"

import { config } from '../lib/init'

export function resetConfig() {
  Object.keys(config || {}).forEach((key) =>
    atom.config.set(`linter-node-markdownlint.${key}`, config[key].default)
  )
}
