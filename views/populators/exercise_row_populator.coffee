class ExerciseRowPopulator extends PagePopulator
  format_date: (d) ->
    pad = (a,b) ->
      (1e15+a+"").slice(-b)
    pad(d.getDate(),2) + '/' + pad(d.getMonth()+1,2) + '/' + d.getFullYear()

  populate: (exercise) ->
    id_cell = @html.find('.id')
    if exercise.handin?
      id_cell.html('')
      handin_anchor = $('<a/>').attr('href', exercise.handin)
                               .html('Hand in')
                               .appendTo(id_cell)

      if exercise.end > (new Date())
        handin_anchor.addClass('handin_link btn btn-primary')
      else
        handin_anchor.addClass('btn btn-danger late_handin')
    else
      id_cell.html('{' + exercise.id + ':' + exercise.type + '}')

    if /\S/.test(exercise.name)
      name_cell = @html.find('td.name')
      name_cell.text(exercise.name)

    @html.find('td.set').text(@format_date exercise.start)
    due_text = @format_date exercise.end

    @html.find('td.due').text due_text
    @html.find('td.due').text

    if exercise.spec?
      spec_cell = @html.find('.spec')
      spec_cell.text('')

      $('<a/>')
        .attr('href', exercise.spec)
        .html('Spec Link').appendTo(spec_cell)

    if exercise.givens?
      givens_cell = @html.find('.given')
      givens_cell.text('')

      $('<a/>')
        .attr('href',exercise.givens)
        .html('Givens').appendTo(givens_cell)
        .data('exercise_title', @html.find('.name').text())
        .bind 'click', (e) =>
          e.preventDefault()
          url = $(this).attr 'href'
          @html.find('#active_given').removeAttr 'id'
          $(this).attr 'id', 'active_given'
          load_cate_page url, (body) ->
            givens_data = extract_givens_page_data(body)
            # populate_givens(givens_data, @html.find('#active_given').data('ex_title'))
            $('#givens-modal').modal('show')
