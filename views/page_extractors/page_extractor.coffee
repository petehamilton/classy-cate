class PageExtractor
  constructor: (html) ->
    @html = html

  extract: ->
    throw ".extract method of PageExtractor should be overriden!"
