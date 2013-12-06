#///////////////////////////////////////////////////////////////////////////////
# Scrapers are responsible for taking some HTML and ripping out the useful
# information
#///////////////////////////////////////////////////////////////////////////////

class PageScraper
  constructor: (html) ->
    @html = html

  extract: ->
    throw ".extract method of PageScraper should be overriden!"
