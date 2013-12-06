class GradesPageExtractor extends PageExtractor
  extract: ->
    process_header_row = (row) ->
      # TODO: Regex out the fluff
      return {
        name: text_extract row.find('td:eq(0)')
        term: text_extract row.find('td:eq(1)')
        submission: text_extract row.find('td:eq(2)')
        level: text_extract row.find('td:eq(3)')
        exercises: []
      }

    process_grade_row = (row) ->
      return {
        id: parseInt(text_extract row.find('td:eq(0)'))
        type: text_extract row.find('td:eq(1)')
        title: text_extract row.find('td:eq(2)')
        set_by: text_extract row.find('td:eq(3)')
        declaration: text_extract row.find('td:eq(4)')
        extension: text_extract row.find('td:eq(5)')
        submission: text_extract row.find('td:eq(6)')
        grade: text_extract row.find('td:eq(7)')
      }

    extract_modules = (table) ->
      grade_rows = table.find('tr')
      grade_rows = grade_rows.slice(2)

      modules = []
      current_module = null;
      grade_rows.each (i, e) ->
        row_elem = $(e)
        tds = row_elem.find('td')
        if tds.length > 1 # Ignore spacer/empty rows
          if $(tds[0]).attr('colspan')
            current_module = process_header_row(row_elem)
            modules.push current_module
          else
            current_module.exercises.push process_grade_row(row_elem)
      return modules

    # TODO: Regex extract useful values
    subscription_last_updated = text_extract @html.find('table:eq(7) table td:eq(1)')
    submissions_completed = text_extract @html.find('table:eq(7) table td:eq(4)')
    submissions_extended = text_extract @html.find('table:eq(7) table td:eq(6)')
    submissions_late = text_extract @html.find('table:eq(7) table td:eq(8)')

    required_modules = extract_modules @html.find('table:eq(9)')
    optional_modules = extract_modules @html.find('table:eq(-2)')

    return {
      stats:
        subscription_last_updated: subscription_last_updated
        submissions_completed: submissions_completed
        submissions_extended: submissions_extended
        submissions_late: submissions_late
      required_modules: required_modules
      optional_modules: optional_modules
    }
