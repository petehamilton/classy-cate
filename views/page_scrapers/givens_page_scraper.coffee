class GivensPageScraper extends PageScraper
  scrape_vars: ->
    categories = []

    # Select the tables
    @html.find('table [cellpadding="3"]')[2..].each(->
      category = {}
      if $(this).find('tr').length > 1  # Only process tables with content
        category.type = $(this).closest('form').find('h3 font').html()[..-2]
        rows = $(this).find('tr')[1..]
        category.givens = []
        for row in rows
          if (cell = $(row).find('td:eq(0) a')).attr('href')?
            category.givens.push {
              title : cell.html()
              link  : cell.attr('href')
            }
        categories.push category
      )

    # Return an array of categories, each element containing a type and rows
    # categories = [ { type = 'TYPE', givens = [{title, link}] } ]
    return categories
