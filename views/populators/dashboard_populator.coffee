class DashboardPopulator extends PagePopulator
  populate: (vars) ->
    @html.find('#cc-identity-profile-image').attr('src', vars.profile_image_src)
    @html.find('#cc-identity-first-name').html(vars.first_name)
    @html.find('#cc-identity-last-name').html(vars.last_name)
    @html.find('#cc-identity-login').html(vars.login)
    @html.find('#cc-identity-category').html(vars.category)
    @html.find('#cc-identity-candidate-number').html(vars.candidate_number)
    @html.find('#cc-identity-cid').html(vars.cid)
    @html.find('#cc-identity-personal-tutor').html(vars.personal_tutor)
    @html.find('#cc-other-projects-portal').attr('href', vars.projects_portal_link)
    @html.find('#cc-other-extensions').attr('href', vars.extensions_link)
    @html.find('#cc-other-documentation').attr('href', vars.documentation_link)

    @html.find('#class-selector li').bind 'click', =>
      @html.find('#current-class')
        .text($(this).text())
        .attr('value',$(this).find('a').attr('value'))
    @html.find('#ex-go-btn').data('keyt',vars.keyt)

    @html.find('#ex-go-btn').bind 'click', =>
      p = @html.find('#term-selector .active').attr 'value'
      c = @html.find('#current-class').attr 'value'
      kt = $(this).data('keyt')
      url = "/timetable.cgi?period=#{p}&class=#{c}&keyt=#{kt}"
      load_exercises_page(null, null, null, url)

    if (period = parseInt vars.default_period)%2 == 0 then period = period - 1
    @html.find('#current-class').attr 'value', vars.default_class
    @html.find('#class-selector a').each =>
      if $(this).attr('value') == vars.default_class
        @html.find('#current-class').text($(this).text())
    @html.find('#term-selector .btn').each ->
      $(this).addClass('active') if $(this).attr('value') == period.toString()

    # lower = new Date()
    # upper = new Date(lower.getTime() + 1000*60*60*24*7 + 1)  # to include full day
    # load_cate_page @html.find('#nav-exercises').attr('href'), (body) ->
    #   vars = extract_exercise_page_data body
    #   [exs_due, exs_late] = [[],[]]
    #   for m in vars.modules
    #     for e in m.exercises
    #       if lower <= e.end <= upper then exs_due.push e
    #       else if e.end < lower and e.handin? then exs_late.push e
    #   if exs_due.length != 0
    #     [vars, fake_module] = [{},{}]
    #     fake_module.exercises = exs_due
    #     vars.modules = [fake_module]
    #     exs = (populate_exercises_page vars, true).sort (a,b) ->
    #       a.end - b.end
    #     @html.find('#exercises_table').append(e.row) for e in exs
    #     create_timeline
    #       structure : TIMELINE_STRUCTURE, moments : exs
    #       destination : @html.find('#exercise_timeline')
    #     @html.find('#exercises_table th').css('cursor','pointer').click ->
    #       @html.find('#exercise_timeline .circle.origin').trigger 'click'
    #     for e in exs
    #       day = 1000*60*60*24
    #       [tomorrow, c] = [new Date(lower.getTime() + day), '']
    #       if (e.end < tomorrow)
    #         c = 'label-important'
    #       else if (e.end < (new Date(tomorrow.getTime() + 2*day)))
    #         c = 'label-warning'
    #       due_cell = e.row.find('.due')
    #       label = $("<span class='label'>#{due_cell.text()}</span>")
    #       label.addClass(c + ' due_label')
    #       due_cell.html('').append label
    #       e.row.data 'bubble', e.info_box
    #       e.row.hover \
    #         (-> $(this).data('bubble').trigger('mouseenter')), \
    #         (-> $(this).data('bubble').trigger('mouseleave'))
    #       e.row.click -> $(this).data('bubble').trigger('click')
    #       e.row.find('.btn').click (e) -> e.stopPropagation()
    #       e.row.css 'cursor', 'pointer'
    #   else populate_exercises_page null, true
