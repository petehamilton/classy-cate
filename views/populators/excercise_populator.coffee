class ExcercisePopulator extends PagePopulator
  constructor: (html, vars) ->
    super(html, vars)
    @forDashboard = false

  format_date = (d) ->
    pad = (a,b) ->
      (1e15+a+"").slice(-b)
    pad(d.getDate(),2) + '/' + pad(d.getMonth()+1,2) + '/' + d.getFullYear()

  populate_exercise_row = (row, ex) ->
    id_cell = row.find('.id')
    if @forDashboard?
      id_cell.text(ex.moduleName)
      id_cell = row.find('.name')
    if ex.handin?
        id_cell.html('')
        handin_anchor = $(document.createElement('a'))
          .attr('href',ex.handin).html('Hand in').appendTo(id_cell)
        handin_anchor.addClass(
          if ex.end > (new Date()) then 'handin_link btn btn-primary' else 'btn btn-danger late_handin')
    else
      if not @forDashboard? or !/\S/.test(ex.name)
        id_cell.html('{'+ex.id+':'+ex.type+'}')
      else id_cell.html('')
    if /\S/.test(ex.name)
      name_cell = row.find('td.name')
      if not @forDashboard?
        name_cell.text(ex.name)
      else name_cell.html(name_cell.html() + ex.name)

    row.find('td.set').text(format_date ex.start)
    due_text = format_date ex.end
    if @forDashboard?
      [day, month, date] = ex.end.toString().split(' ')
      due_text = day + ' ' + date

    row.find('td.due').text due_text
    row.find('td.due').text

    if ex.spec?
      (specCell = row.find('.spec')).text('')
      ex.spec_element = $(document.createElement('a')).attr('href',ex.spec).html('Spec Link').appendTo(specCell)

    if ex.givens?
      givensCell = row.find('.given').text('')
      ex.given_element = $(document.createElement('a')).attr('href',ex.givens)
        .html('Givens').appendTo(givensCell)
        .data('ex_title', row.find('.name').text())
        .bind 'click', (e) ->
          e.preventDefault()
          url = $(this).attr 'href'
          @html.find('#active_given').removeAttr 'id'
          $(this).attr 'id', 'active_given'
          load_cate_page url, (body) ->
            givens_data = extract_givens_page_data(body)
            populate_givens(givens_data, @html.find('#active_given').data('ex_title'))
            @html.find('#givens-modal').modal('show')


  destination_div = @html.find('#page-content')
  destination_div = @html.find('#exercise-timeline') if @forDashboard?
  (modules = vars.modules) if vars?
  if not @forDashboard?
    @html.find('#term_title').text('Timetable - ' + vars.term_title)

  if vars? then for module in modules # Don't ignore empty module
    if not @forDashboard?
      module_header = $("<h3>#{module.id} - #{module.name}</h3>")

    if module.notesLink? and not @forDashboard?
      note_link = @html.find('<a/>').attr('href', module.notesLink).html('Notes')
        .data('module_title',module_header.text())  # Save title link for modal

      note_link.bind 'click', (e) ->
          e.preventDefault()
          url = $(this).attr 'href'
          @html.find('#active_note').removeAttr 'id'
          $(this).attr 'id', 'active_note'
          load_cate_page url, (body) ->
            notes_data = extract_notes_page_data(body)
            notes_data.title = @html.find('#active_note').data('module_title')
            populate_notes(@html, notes_data)
            $("#notes-modal").modal('show')
      module_header.append(" - ").append(note_link)
      destination_div.append module_header

    if module.exercises[0]?
      module_table = @html.find('#exercises_table')
      if not @forDashboard?
        module_table = @html.find('#exercises_template').clone()
      module_table.removeClass('hidden')

      for exercise in module.exercises
        row = @html.find('#exercise_row_template').clone()
        if not @forDashboard?
          row.removeClass('hidden').appendTo(module_table)
        else exercise.row = row.removeClass('hidden')  # rememeber to append
        populate_exercise_row row, exercise
      destination_div.append(module_table) if not @forDashboard?

      if @forDashboard? then return module.exercises

      placeholder = @html.find('<div/ class="timeline_slider">').appendTo destination_div
      timeline = create_timeline
                destination : placeholder
                structure : TIMELINE_STRUCTURE, moments : module.exercises
      .hide()

      timeline_icon = @html.find('<i/ rel="tooltip" title="Toggle timeline" class="icon-time timeline_toggle">')
        .data
          'clicked' : false
          'timeline' : timeline
          'placeholder' : placeholder
        .bind 'click', ->
          $(this).data 'clicked', (clicked = !$(this).data 'clicked')
          [timeline, placeholder] = [$(this).data('timeline'), $(this).data('placeholder')]
          if clicked
            placeholder.animate {minHeight : 150}, {duration : 400, complete : -> timeline.fadeIn()}
          else
            timeline.fadeOut
              complete : -> placeholder.animate {minHeight : 0, height : 'auto'}, {duration : 400}
        .tooltip {placement : 'left', delay : {show : 500, hide : 100}}

      module_header.append timeline_icon

  if not modules? or Math.max((m.exercises.length for m in vars.modules)...) <= 0
    no_modules = @html.find('<div/>').css
      textAlign : 'center', paddingTop : '50px', paddingBottom : '50px'
    .append @html.find('<div/ class="well">').append("<h4>There's no handins here!</h4>")
    @html.find('#page-content').append no_modules

  if not @forDashboard?
    @html.find('#back_term_btn').bind 'click', ->
        if PERIOD != 1 then load_exercises_page null, null, -1
    @html.find('#next_term_btn').bind 'click', ->
        if PERIOD != 6 then load_exercises_page null, null, 1
