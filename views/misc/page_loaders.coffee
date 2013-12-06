#///////////////////////////////////////////////////////////////////////////////
# Code to load pages
#///////////////////////////////////////////////////////////////////////////////

load_dashboard_page = (e) ->
  e.preventDefault() if e?
  window.location.hash = "dashboard"
  url = $('#nav-dashboard').attr('href')
  load_cate_page url, (body) ->
    vars = (new MainPageExtractor(body)).extract
    populate_html('#page-content', MAIN_PAGE_TEMPLATE_HTML)
    (new MainPagePopulator($('#page-content'), vars)).populate


load_grades_page = (e) ->
  e.preventDefault() if e?
  window.location.hash = "grades"
  load_cate_page $('#nav-grades').attr('href'), (body) ->
    vars = (new GradesPageExtractor(body)).extract
    populate_html('#page-content', GRADES_PAGE_TEMPLATE_HTML)
    (new GradesPagePopulator($('#page-content'), vars)).populate

load_exercises_page = (e, fallback, shifting, url) ->

  if e?
    e.preventDefault()
    url = e.target.getAttribute('href')

  get_period_from_href = (href) ->
    parseInt href.split('period=')[1][0]

  alter_href_by = (href, i) ->
    p = (get_period_from_href href)
    href.replace(('period=' + p),('period=' + (p + i)))

  isHoliday = (period) -> period%2 == 0

  get_url_for_period = (p) ->
    crrt = $('#nav-exercises').attr('href').split('period=')
    crrt[0] + 'period=' + p + crrt[1][1..]

  window.location.hash = "timetable"

  href = $('#nav-exercises').attr('href')
  if shifting?
    PERIOD = PERIOD + shifting
    href = get_url_for_period PERIOD
  else if fallback?
    href = alter_href_by href, (-1)
  else if url?
    href = url

  PERIOD = get_period_from_href href

  load_cate_page href, (body) ->
    exercise_page_vars = extract_exercise_page_data body
    go_forth_and_multiply = true
    if isHoliday(get_period_from_href href) and (not shifting? or url?)
      noOfExercises = 0
      for m in exercise_page_vars.modules
        noOfExercises += m.exs.length if m.exs?
      if noOfExercises == 0
        go_forth_and_multiply = false
        load_exercises_page e, true, null
    if go_forth_and_multiply
      populate_html('#page-content', EXERCISES_PAGE_HTML)
      populate_exercises_page(exercise_page_vars)