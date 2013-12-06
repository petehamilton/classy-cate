class MainPageScraper extends Scraper
  extract: ->
    current_url = document.URL
    current_year = current_url.match("keyp=([0-9]+)")[1] #TODO: Error check
    current_user = current_url.match("[0-9]+:(.*)")[1] # TODO: Error Check

    version = @html.find('table:first td:first').text()

    profile_image_src = @html.find('table:eq(2) table:eq(1) tr:eq(0) img').attr('src')

    profile_fields = @html.find('table:eq(2) table:eq(1) tr:eq(1) td').map (i, e) -> $(e).text()
    first_name = profile_fields[0]
    last_name = profile_fields[1]
    login = profile_fields[2]
    category = profile_fields[3]
    candidate_number = profile_fields[4]
    cid = profile_fields[5]
    personal_tutor = profile_fields[6]

    available_years = @html.find('select[name=newyear] option').map (index, elem) ->
      elem = $(elem)
      {text: elem.html(), href: elem.attr('value')}
    available_years = available_years.slice(1)

    other_func_links = @html.find('table:eq(2) table:eq(9) tr td:nth-child(3) a').map (index, elem) ->
      $(elem).attr('href')

    grading_schema_link = other_func_links[0]
    documentation_link = other_func_links[1]
    extensions_link = other_func_links[2]
    projects_portal_link = other_func_links[3]
    individual_records_link = other_func_links[4]

    default_class = @html.find('input[name=class]:checked').val()
    default_period = @html.find('input[name=period]:checked').val()

    keyt = @html.find('input[type=hidden]').val()

    timetable_url = '/timetable.cgi?period=' + default_period + '&class=' + default_class + '&keyt=' + keyt

    return {
      current_url: current_url
      current_year: current_year
      current_user: current_user
      version: version
      profile_image_src: profile_image_src
      first_name: first_name
      last_name: last_name
      login: login
      category: category
      candidate_number: candidate_number
      cid: cid
      personal_tutor: personal_tutor
      available_years: available_years
      grading_schema_link: grading_schema_link
      documentation_link: documentation_link
      extensions_link: extensions_link
      projects_portal_link: projects_portal_link
      individual_records_link: individual_records_link
      default_class: default_class
      default_period: default_period
      keyt: keyt
      timetable_url: timetable_url
    }
