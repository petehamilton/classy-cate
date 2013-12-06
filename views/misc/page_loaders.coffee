#///////////////////////////////////////////////////////////////////////////////
# Code to load pages
#///////////////////////////////////////////////////////////////////////////////

load_cate_page = (url, callback) ->
  $.ajax
    type: 'GET'
    url: url
    dataType: 'html'
    success: (data) ->
      data = data.split(/<body.*>/)[1].split('</body>')[0]
      body = $('<body/>').append(data)
      # remove icons - cates really bad at providing them for
      # an ajax, was hanging terribly in safari
      icons = body.find('img[src^="icons/"]')
      icons.remove()
      callback body

load_dashboard_page = (e) ->
  e.preventDefault() if e?
  window.location.hash = "dashboard"
  url = $('#nav-dashboard').attr('href')
  load_cate_page url, (old_body) ->
    scraper = new MainPageScraper old_body
    populator = new DashboardPopulator $('body')
    vars = scraper.scrape_vars()
    replace_html('#page-content', DASHBOARD_PAGE_TEMPLATE_HTML)
    populator.populate(vars)

load_grades_page = (e) ->
  e.preventDefault() if e?
  window.location.hash = "grades"
  url = $('#nav-grades').attr('href')
  load_cate_page url, (old_body) ->
    scraper = new GradesPageScraper old_body
    populator = new GradesPopulator $('body')
    vars = scraper.scrape_vars()
    replace_html('#page-content', GRADES_PAGE_TEMPLATE_HTML)
    populator.populate(vars)

load_exercises_page = (e, period, url) ->

  isHoliday = (period) -> period % 2 == 0

  get_period_from_url = (url) ->
    parseInt url.split('period=')[1][0]

  get_url_for_period = (p) ->
    crrt = $('#nav-exercises').attr('href').split('period=')
    crrt[0] + 'period=' + p + crrt[1][1..]

  e.preventDefault() if e?
  window.location.hash = "exercises"

  url = $('#nav-exercises').attr('href') unless url?
  period = get_period_from_url(url) unless period?
  url = get_url_for_period(period)

  load_cate_page url, (old_body) ->
    scraper = new ExercisePageScraper old_body
    populator = new ExercisePopulator $('#page-content')
    vars = scraper.scrape_vars()
    vars.period = period
    replace_html('#page-content', EXERCISES_PAGE_TEMPLATE_HTML)
    populator.populate(vars)
