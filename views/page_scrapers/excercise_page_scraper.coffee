class ExcercisePageScraper extends PageScraper
  scrape_vars: ->
    # Extracts full title e.g. Spring Term 2012-2013
    extract_term_title = (html) ->
      html.find('tr').eq(0).find('h1').eq(0).text()

    # Converts a CATE style date into a JS Date object
    # e.g. '2013-1-7' -> Mon Jan 07 2013 00:00:00 GMT+0000 (GMT)
    parse_date = (input) ->
      [year, month, day] = input.match(/(\d+)/g)
      new Date(year, month - 1, day) # JS months index from 0

    # Extracts the academic years applicable
    # e.g. "Easter Period 2012-2013" -> ["2012", "2013"]
    extract_academic_years = (body) ->
      body.find('h1').text()[-9..].split('-')

    extract_start_end_dates = (fullTable, years) ->
      # Converts a month into an int (indexed from 1)
      # e.g. "January" -> 1
      # month - Month name as a capitalised string
      month_to_int = (m) ->
        months = ['January', 'February', 'March', 'April', 'May', 'June', 'July',
                  'August', 'September', 'October', 'November', 'December']
        return 6 if m == 'J'
        rexp = new RegExp(m,'g')
        for month,i in months
              if rexp.test(month) then return i+1

      # Extracts months from table row
      # e.g. ["January", "February", "March"]
      # table_row - The Timetable table row jQuery Object
      extract_months = (table_row) ->
        table_headers = ($(cell) for cell in table_row.find('th'))
        month_cells = (c for c in table_headers when c.attr('bgcolor') == "white")
        month_names = (c.text().replace(/\s+/g, '') for c in month_cells)
        month_ids = month_names.map month_to_int
        return month_ids

      # Extracts days from table row
      # e.g. ["1", "2", "3"]
      # table_row - The Timetable table row jQuery Object
      extract_days = (table_row) ->
        table_headers = ($(cell) for cell in table_row.find('th'))
        days_text = (c.text() for c in table_headers)
        valid_days = (d for d in days_text when d.replace(/\s+/g, '') != '')
        days_as_ints = valid_days.map parseFloat # Parse int was going nuts, '23' -> 54???
        return days_as_ints

      # TODO: What if the timetable crosses year boundaries?
      #       e.g over new year/christmas?

      [first_month, others..., last_month] = extract_months $(fullTable).find('tr').eq(0)

      year = if first_month < 9 then years[1] else years[0]

      day_headers = $(fullTable).find('tr').eq(2).find('th')

      col_buf = 0
      col_buf += 1 while $(day_headers[col_buf]).is(":empty")

      [first_day, others..., last_day] = extract_days $(fullTable).find('tr').eq(2)

      return {  # remember _day in yyyy-mm-dd format
        start: year + '-' + first_month + '-' + first_day
        end: year + '-' + last_month + '-' + last_day
        colBufferToFirst: col_buf - 1
      }

    # Extracts module details from a cell jQuery object
    process_module_cell = (cell) ->
      [id, name] = cell.text().split(' - ')
      return {
        id : id
        name : name.replace(/^\s+|\s+$/g, '')
        notesLink : cell.find('a').eq(0).attr('href')
      }

    # Add the parsed exercises to the given module
    # module - the module to attach the exercises to
    # exercise_cells - An array of cells (jQuery objects)
    process_exercises_from_cells = (module, exercise_cells) ->
      if not exercise_cells? then return null
      module.exercises ?= []

      current_date = parse_date dates.start
      current_date.setDate(current_date.getDate() - dates.colBufferToFirst)
      for ex_cell in exercise_cells
        colSpan = parseInt($(ex_cell).attr('colspan') ? 1)
        colSpan = 1 if colSpan == NaN
        if $(ex_cell).attr('bgcolor')? and $(ex_cell).find('a').length != 0
          [id, type] = $(ex_cell).find('b').eq(0).text().split(':')
          hrefs = ($(anchor).attr('href') for anchor in $(ex_cell).find('a') when $(anchor).attr('href')?)
          [mailto, spec, givens, handin] = [null, null, null, null]
          for href in hrefs
            if /mailto/i.test(href)
              mailto = href
            else if /SPECS/i.test(href)
              spec = href
            else if /given/i.test(href)
              givens = href
            else if /handins/i.test(href)
              handin = href

          end = new Date(current_date.getTime())
          end.setDate(end.getDate() + colSpan - 1)
          exercise_data = {
            id : id, type : type, start : new Date(current_date.getTime())
            end : end, moduleName : module.name
            name : $(ex_cell).text()[(id.length + type.length + 2)..].replace(/^\s+|\s+$/g,'')
            mailto : mailto, spec : spec, givens : givens, handin : handin
          }

          module.exercises.push(exercise_data)
        current_date.setDate (current_date.getDate() + colSpan)

    extract_module_exercise_data = (fullTable) ->

      # Returns whether or not an element is a module container
      # elem - jQuery element
      is_module = (elem) ->
        elem.find('font').attr('color') == "blue"

      allRows = $(fullTable).find('tr')
      modules = []
      count = 0
      while count < allRows.length
        current_row = allRows[count]
        following_row_count = 0
        module_elem = $($(current_row).find('td').eq(1))
        if is_module(module_elem)
          module_data = process_module_cell module_elem

          following_row_count = $(current_row).find('td').eq(0).attr('rowspan') - 1
          following_rows = allRows[count+1..count+following_row_count]

          exerciseCells = ($(row).find('td')[1..] for row in following_rows)
          exerciseCells.push($(current_row).find('td')[4..])
          exerciseCells = (cs for cs in exerciseCells when cs?)

          process_exercises_from_cells(module_data, cells) for cells in exerciseCells

          modules.push module_data
        count += following_row_count + 1
      return modules

    term_title = extract_term_title @html
    timetable = (tb for tb in @html.find('table') when $(tb).attr('border') == "0")
    dates = extract_start_end_dates timetable, extract_academic_years @html   # WRONG
    modules = extract_module_exercise_data timetable
    m.exercises.sort ((a,b) -> if a.start < b.start then -1 else 1) for m in modules
    return {
      modules : modules
      start : dates.start, end : dates.end
      term_title : term_title
    }
