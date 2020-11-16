# linter-node-markdownlint

[![Test](https://github.com/josa42/atom-linter-node-markdownlint/workflows/Main/badge.svg?branch=master)](https://github.com/josa42/atom-linter-node-markdownlint/actions?query=workflow%3AMain)
[![Plugin installs!](https://img.shields.io/apm/dm/linter-node-markdownlint.svg?style=flat-square)](https://atom.io/packages/linter-node-markdownlint)
[![Package version!](https://img.shields.io/apm/v/linter-node-markdownlint.svg?style=flat-square)](https://atom.io/packages/linter-node-markdownlint)

This linter plugin for [Linter](https://github.com/AtomLinter/Linter) provides
an interface to [markdownlint](https://github.com/DavidAnson/markdownlint).

## Configuration

The package reads the configuration from the `.markdownlintrc` file.

The configuration file can be formatted as [`JSON`](http://json.org/example) or [`INI`](https://en.wikipedia.org/wiki/INI_file).

### JSON Example

```js
{
  "default": true,
  "MD003": { "style": "atx_closed" },
  "MD007": { "indent": 4 },
  "no-hard-tabs": false,
  "MD018": false
}
```

### INI Example

```ini
default=true
no-hard-tabs=false
MD018=false

[MD003]
style=atx_closed

[MD007]
indent=4
```

For more information checkout:

* The markdownlint [list of rules](https://github.com/DavidAnson/markdownlint/blob/master/doc/Rules.md)
* The markdownlint [list of tags](https://github.com/DavidAnson/markdownlint#rules--aliases)
* The markdownlint-cli [configuration file example](https://github.com/igorshubovych/markdownlint-cli#configuration)
