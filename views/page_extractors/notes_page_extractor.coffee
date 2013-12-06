class NotesPageExtractor extends NotesPageExtractor
  extract: ->
    process_notes_rows = (html) ->
      html.find('table [cellpadding="3"]').find('tr')[1..]

    notes = []
    for row in ($(r) for r in process_notes_rows(@html)
      title = row.find('td:eq(1)').text()
      link = $(row.find('td:eq(1) a'))
      if link.attr('href')? && link.attr('href') != ''
        notes.push {
          type: "resource"
          title: title
          link: link.attr('href')
        }
      else if link.attr('onclick')? # Remote page
        identifier = link.attr('onclick').match(/clickpage\((.*)\)/)[1]
        href = "showfile.cgi?key=2012:3:#{identifier}:c3:NOTES:peh10"
        notes.push {
          type: "url"
          title : title
          link : href
        }

    return { notes: notes }
