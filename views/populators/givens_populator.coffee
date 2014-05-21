class GivensPopulator extends PagePopulator
  populate: ->
    # @vars = [ { type = 'TYPE', givens = [{title, link}] } ]
    givens_header = @html.find('#givens-modal-header')
    givens_header.find('h3').remove()
    givens_header.append("<h3>#{@vars.header}</h3>")
    givens_table = @html.find('#givens-table')
    givens_table.html('')
    for category in @vars
      head = @html.find('<thead/>').append $("<tr><th colspan='2'><h4>#{category.type}</h4></th></tr>")
      head.append @html.find('<tr><th class="id">ID</th><th>Link</th></tr>')
      tbody = @html.find('<tbody/>')
      for given, i in category.givens
        row = @html.find('<tr/>')
        row.append("<td>#{i+1}</td>")
        row.append("<td><a href='#{given.link}'>#{given.title}</a></td>")
        tbody.append row
      givens_table.append(head)
      givens_table.append(tbody)

