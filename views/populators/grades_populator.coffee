class GradesPopulator extends PagePopulator
  populate: (vars) ->
    @html.find('#cc-subscription-updated').html(vars.stats.subscription_last_updated)
    @html.find('#cc-submissions-completed').html(vars.stats.submissions_completed)
    @html.find('#cc-submissions-extended').html(vars.stats.submissions_extended)
    @html.find('#cc-submissions-late').html(vars.stats.submissions_late)

    $(vars.required_modules).each (i, module) =>
      @html.find('#cc-required-modules').append(@render_module module)

    $(vars.optional_modules).each (i, module) =>
      @html.find('#cc-optional-modules').append(@render_module module)

  grade_to_class: (grade) ->
    switch grade
      when "A*", "A+", "A" then "progress-success"
      when "B"  then "progress-info"
      when "C", "D" then "progress-warning"
      when "E", "F" then "progress-danger"

  grade_to_width: (grade) ->
    width = switch grade
      when "A*" then 100
      when "A+" then 90
      when "A"  then 80
      when "B"  then 70
      when "C"  then 60
      when "D"  then 50
      when "E"  then 40
      when "F"  then 30
      else 0
    "#{width}%"

  render_module: (module) ->
    module_elem = @html.find('#module_template .row').clone()
    module_elem.find('.module-title').html(module.name)

    grades_table = module_elem.find('.module-grades')
    if module.exercises.length == 0
      grades_table.append($('<tr><td colspan="8">No exercises for this module.</td></tr>'))
    else
      $(module.exercises).each (i, exercise) =>
        exercise_elem = @html.find('#exercise_template tr').clone()
        exercise_elem.find('.exercise-id').html(exercise.id)
        exercise_elem.find('.exercise-type').html(exercise.type)
        exercise_elem.find('.exercise-title').html(exercise.title)
        exercise_elem.find('.exercise-set-by').html(exercise.set_by)
        exercise_elem.find('.exercise-declaration').html(exercise.declaration)
        exercise_elem.find('.exercise-extension').html(exercise.extension)
        exercise_elem.find('.exercise-submission').html(exercise.submission)

        switch exercise.grade
          when ""
            exercise_elem.find('.exercise-grade-container').html("No Record")
          when "n/a"
            exercise_elem.find('.exercise-grade-container').html('<i class="icon-legal" /> Awaiting Marking')
          when "N/P"
            exercise_elem.find('.exercise-grade-container').html('<i class="icon-lock" /> Marked, Not Published')
          else
            exercise_elem.find('.progress').addClass(@grade_to_class(exercise.grade))
            exercise_elem.find('.progress .bar').css('width', @grade_to_width(exercise.grade))
            exercise_elem.find('.exercise-grade').html(exercise.grade)
        grades_table.append(exercise_elem)
    return module_elem
