activate_nostalgia_mode = ->
  nostalgia_colors = ['Teal', 'DarkCyan', 'DeepSkyBlue', 'DarkTurquoise', 'MediumSpringGreen',
                     'Lime', 'SpringGreen', 'Aqua', 'Cyan', 'MidnightBlue', 'DodgerBlue',
                     'LightSeaGreen', 'Turquoise', 'RoyalBlue', 'SteelBlue', 'MediumTurquoise',
                     'CadetBlue', 'CornflowerBlue', 'MediumAquaMarine']

  $('body, footer, div, span, td, input').each (index, elem) ->
    random_nostalgia_color = nostalgia_colors[Math.floor(Math.random()*nostalgia_colors.length)]
    $(elem).css('background', random_nostalgia_color)

  $('#old-cate-button').unbind()
  $('#old-cate-button').html("Mother of God, make it stop!")
  $('#old-cate-button').bind 'click', ->
    alert('Nope, you made your bed, now lie in it...')

populate_html = (element, raw) ->
  $(element).html($("<div/>").html(raw).text())

text_extract = (html) ->
  html.text().trim().replace(/(\r\n|\n|\r)/gm,"");

load_cate_page = (url, callback) ->
  $.ajax
    type: 'GET'
    url: url
    dataType: 'html'
    success: (data) ->
      data = data.split(/<body.*>/)[1].split('</body>')[0]
      body = $('<body/>').append(data)
      # remove icons- cates really bad at providing them for
      # an ajax, was hanging terribly in safari
      icons = body.find('img[src^="icons/"]')
      icons.remove()
      callback body

load_css = ->
  # Let's Bootstrap this shizzle. Files from http://www.bootstrapcdn.com/?v=01282013154951
  $('head').append('<link rel="stylesheet" href="//netdna.bootstrapcdn.com/twitter-bootstrap/2.2.2/css/bootstrap-combined.min.css" type="text/css" />');
  $('head').append('<link rel="stylesheet" href="//netdna.bootstrapcdn.com/font-awesome/3.0/css/font-awesome.css" type="text/css" />');
  $('head').append('<link rel="stylesheet" href="<%= settings.cc_css_url %>" type="text/css" />');
