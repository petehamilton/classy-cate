class PagePopulator
  constructor: (html, vars) ->
    @html = html

  populate: (vars) ->
    throw ".populate method of PagePopulator should be overriden!"
