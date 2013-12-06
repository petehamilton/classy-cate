class ExercisePopulator extends PagePopulator
  constructor: (html, vars) ->
    super(html, vars)

  populate: (vars) ->
    @html.find('#term_title').text('Timetable - ' + vars.term_title)

    for module in vars.modules
      module_header = $("<h3>#{module.id} - #{module.name}</h3>")

      if module.notesLink?
        note_link = $('<a/>').attr('href', module.notesLink).html('Notes')
                             .data('module_title', module_header.text())
        note_link.bind 'click', (e) =>
          e.preventDefault()
          url = $(e.target).attr 'href'
          console.log "Notes for #{url}"
          @html.find('#active_note').removeAttr 'id'
          $(e.target).attr 'id', 'active_note'
          load_cate_page url, (body) =>
            scraper = new NotesPageScraper(body)
            populator = new NotesPopulator(@html.find('#notes-modal'))
            notes_data = scraper.scrape_vars()
            notes_data.title = @html.find('#active_note').data('module_title')
            populator.populate(notes_data)
            $("#notes-modal").modal('show')
        module_header.append(" - ").append(note_link)
      @html.append module_header

      if module.exercises.length > 0
        module_table = @html.find('#exercises_table')
        module_table = @html.find('#exercises_template').clone()
        module_table.removeClass('hidden')

        for exercise in module.exercises
          row = @html.find('#exercise_row_template').clone()
          row.removeClass('hidden').appendTo(module_table)
          populator = new ExerciseRowPopulator(row)
          populator.populate(exercise)
        @html.append(module_table)

    if not modules? or Math.max((m.exercises.length for m in vars.modules)...) <= 0
      el = $('<div/>')
      el.css
        textAlign: 'center'
        paddingTop: '50px'
        paddingBottom: '50px'
      el.append $('<div/ class="well">').append("<h4>There's no handins here!</h4>")
      @html.find('#page-content').append el

    if vars.period != 1
      @html.find('#back_term_btn').bind 'click', (e) -> load_exercises_page e, vars.period - 1
    else
      @html.find('#back_term_btn').addClass('disabled')
    if vars.period != 6
      @html.find('#next_term_btn').bind 'click', (e) -> load_exercises_page e, vars.period + 1
    else
      @html.find('#next_term_btn').addClass('disabled')
