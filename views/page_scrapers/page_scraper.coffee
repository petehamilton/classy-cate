#///////////////////////////////////////////////////////////////////////////////
# Scrapers are responsible for taking some HTML and ripping out the useful
# information
#///////////////////////////////////////////////////////////////////////////////

class PageScraper
  constructor: (html) ->
    @html = html

  scrape_vars: ->
    throw ".scrape method of PageScraper should be overriden!"
