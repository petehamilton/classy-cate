class PagePopulator
  constructor: (html, vars) ->
    @html = html
    @vars = vars

  populate: ->
    throw ".populate method of PagePopulator should be overriden!"
