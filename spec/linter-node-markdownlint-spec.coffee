{ resetConfig } = require './test-helper'

MarkdownlitProvider = require '../lib/markdownlint-provider'

describe "Lint markdown", ->
  beforeEach ->
    waitsForPromise -> atom.packages.activatePackage('linter-node-markdownlint')
    resetConfig()

  describe "bad", ->
    it 'should retun 4 errors', ->

      waitsForProise ->
        atom.workspace.open('./files/bad.md')
          .then (editor) -> MarkdownlitProvider.lint(editor)
          .then (messages) ->
            expect(messages.length).toEqual(4)
            expect(messages[0].text).toEqual("MD010 Hard tabs")
            expect(messages[0].range).toEqual([[2, 0], [2, 7]])

            expect(messages[1].text).toEqual("MD018 No space after hash on atx style header")
            expect(messages[1].range).toEqual([[2, 0], [2, 7]])

            expect(messages[2].text).toEqual("MD018 No space after hash on atx style header")
            expect(messages[2].range).toEqual([[2, 0], [2, 7]])

            expect(messages[3].text).toEqual("MD041 First line in file should be a top level header")
            expect(messages[3].range).toEqual([[2, 0], [2, 7]])
