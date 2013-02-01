/*
* @name         CATE 2.0
* @author       Pater Hamilton
* @description  CATE hurts my eyes. This makes them hurt less
*/

// TODO: Have a button which turns off the skin/improvements?
// TODO: Move sections out into functions. Originally this wasn't possible,
//       hence the ugly all-in-one-function implementation below
(function(){
    console.log("External Classy CATE JS Loaded");


    ////////////////////////////////////////////////////////////////////////////
    // Move everything into a bootstrap container //////////////////////////////
    ////////////////////////////////////////////////////////////////////////////
    $('body').wrapInner('<div class="container" />');
    container = $('.container');


    ////////////////////////////////////////////////////////////////////////////
    // Extract URL Vars ////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////
    //TODO: Make this work for any CATE page
    CURRENT_URL = document.URL;
    CURRENT_YEAR = CURRENT_URL.match('keyp=([0-9]+)')[1]; //TODO: Error check
    CURRENT_USER = CURRENT_URL.match('[0-9]+:(.*)')[1]; // TODO: Error Check


    ////////////////////////////////////////////////////////////////////////////
    // Navigation //////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////
    navbar = $('<div class="navbar" />');
    navbar_inner = $('<div class="navbar-inner" />');
    navbar_container= $('<div class="container" />');
    navbar_links = $('<ul class="nav" />');

    //TODO: Work out the active link
    //TOOD: Figure out the correct URLs
    navbar_links.append('<li><a id="nav-exercises" href="#">Exercises</a></li>');
    navbar_links.append('<li><a id="nav-grades" href="#">Grades</a></li>');
    navbar_links.append('<li><a id="nav-teachdb" href="https://teachdb.doc.ic.ac.uk/db/">Teach DB</a></li>');
    navbar_links.append('<li><a id="nav-internalreg" href="https://dbc.doc.ic.ac.uk/internalreg">Module Registration</a></li>');

    // Nicer Year Picker Dropdown
    year_dropdown_container = $('<ul class="nav pull-right" />');
    year_dropdown = $('<li class="dropdown" />');
    year_dropdown_list = $('<ul class="dropdown-menu" role="menu" />');
    year_dropdown.append(year_dropdown_list);
    year_dropdown_container.append(year_dropdown);

    navbar_collapsed_bars = '<a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">' +
                            '  <span class="icon-bar"></span>' +
                            '  <span class="icon-bar"></span>' +
                            '  <span class="icon-bar"></span>' +
                            '</a>';
    navbar_branding = $('<a class="brand" href="/">CATE <span id="cate-version">X</span></a>');
    navbar_collapsed = $('<div class="nav-collapse collapse" />');

    navbar_collapsed.append(navbar_collapsed);
    navbar_collapsed.append(navbar_branding);
    navbar_collapsed.append(navbar_links);
    navbar_collapsed.append(year_dropdown_container);

    navbar_container.append(navbar_collapsed_bars);
    navbar_container.append(navbar_branding);
    navbar_container.append(navbar_collapsed);

    navbar_inner.append(navbar_container);
    navbar.append(navbar_inner);
    container.prepend(navbar);



    ////////////////////////////////////////////////////////////////////////////
    // Move Header Bits to Navbar
    ////////////////////////////////////////////////////////////////////////////
    // TODO: Clean up this ugly mess
    header_container = $('.container center:first');

    t = $('table:first');
    version = t.find("td:first font").html();
    $('#cate-version').html('<a href="/ChangesLog.html">' + version + '</a>');

    info = $('<div class="span4"/>');
    info.html(t.find("td:eq(2)").html());

    year_changelog = $('<div class="span4"/>');
    year_changelog.html(t.find("td:eq(4)").html());
    year = $(year_changelog.find('td:eq(0)').html());
    year_changelog.find("select[name=newyear] option").each(function (index){
        if(index > 0) { // Ignore initial option/helptext
            year_dropdown_list.append('<li><a href="' + $(this).attr('value') + '">' + $(this).html() + '</a></li>');
        }
    });

    year_dropdown.append('<a class="dropdown-toggle" data-toggle="dropdown" href="#">(' + CURRENT_YEAR + ') Change Year <b class="caret"></b></a>');
    year_dropdown.append(year_dropdown_list);

    // Remodel the profile table
    main_cate_table = $('table:eq(2)');
    console.log(main_cate_table);
    title_row = main_cate_table.find('td table td table tr:eq(0)');
    profile_image = title_row.find('img');
    profile_image.removeAttr('height');
    profile_image.addClass('profile-image');
    console.log(profile_image);
    field_titles = title_row.find('th').slice(1).map(function(i, val) { return $(val).html(); });

    value_row = main_cate_table.find('td table td table tr:eq(1)');
    field_values = value_row.find('td big b').map(function(i, val) { return $(val).html().replace("<br>", " "); });

    identity_row = $('<div id="identity-container" class="row"/>');
    identity_span = $('<div class="span4"/>');
    identity_table = $('<table class="table table-bordered table-striped" />');
    profile_image_string = $('<div>').append(profile_image.clone()).html(); //TODO: Remove Hack
    identity_table.append('<tr><td class="profile-picture-container" rowspan=7>' + profile_image_string + '</td><td><b>' + field_titles[0] + '</b></td><td>' + field_values[0] + '</td></tr>');
    field_titles.each(function(index){
        if(index > 0) {
            identity_table.append('<tr><td><b>' + field_titles[index] + '</b></td><td>' + field_values[index] + '</td></tr>');
        }
    });
    identity_span.append('<h1 class="section-header">Identity</h1>');
    identity_span.append(identity_table);
    identity_row.append(identity_span);

    $('.navbar').after(identity_row);


    ////////////////////////////////////////////////////////////////////////////
    // Add nicer exercise timetable selection //////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////
    classes_container = $('<div class="span4"/>');
    classes_container.append('<h1 class="section-header">Exercise Timetable</h1>');

    period_select = $('<select id="period-select" name="period" />');
    period_select.append('<option value="1">Autumn Term</option>');
    period_select.append('<option value="2">Christmas</option>');
    period_select.append('<option value="3">Spring Term</option>');
    period_select.append('<option value="4">Easter</option>');
    period_select.append('<option value="5">Summer Term</option>');
    period_select.append('<option value="6">June-July</option>');
    period_select.append('<option value="7">August-September</option>');
    default_period = $('input[name=period]:checked').val();
    period_select.val(default_period);
    class_select = $('<select id="class-select" name="class" />');
    class_select.append('<option value="c1">COMP 1</option>');
    class_select.append('<option value="c2">COMP 2</option>');
    class_select.append('<option value="c3">COMP 3</option>');
    class_select.append('<option value="c4">COMP 4</option>');

    class_select.append('<option value="j1">JMC 1</option>');
    class_select.append('<option value="j2">JMC 2</option>');
    class_select.append('<option value="j3">JMC 3</option>');
    class_select.append('<option value="j4">JMC 4</option>');

    class_select.append('<option value="i2">ISE 2</option>');
    class_select.append('<option value="i3">ISE 3</option>');
    class_select.append('<option value="i4">ISE 4</option>');

    class_select.append('<option value="v5">Computing</option>');
    class_select.append('<option value="s5">Computing Spec.</option>');
    class_select.append('<option value="a5">Advanced</option>');
    class_select.append('<option value="r5">Research</option>');
    class_select.append('<option value="y5">Industrial</option>');
    class_select.append('<option value="b5">Bioinformatic</option>');

    class_select.append('<option value="occ">Occasional</option>');
    class_select.append('<option value="r6">PhD</option>');
    class_select.append('<option value="ext">External</option>');

    default_class = $('input[name=class]:checked').val();
    class_select.val(default_class);

    hidden_details = $('input[type=hidden]');
    keyt = hidden_details.val();
    hidden_details.attr('id', 'keyt');

    submission_button = $('<button class="btn">Go</button>');

    form = $(  '<form class="form-horizontal" action="/timetable.cgi" type="GET" >' +
               '    <div class="control-group">' +
               '        <label class="control-label" for="period-select">Period</label>' +
               '        <div id="period-select-container" class="controls">' +
               '        </div>' +
               '    </div>' +
               '    <div class="control-group">' +
               '        <label class="control-label" for="class-select">Class</label>' +
               '        <div id="class-select-container" class="controls">' +
               '        </div>' +
               '    </div>' +
               '    <div class="control-group">' +
               '        <div id="button-container" class="controls">' +
               '        </div>' +
               '    </div>' +
               '</form>'
             );
    form.find('#period-select-container').append(period_select);
    form.find('#class-select-container').append(class_select);
    form.find('#button-container').append(submission_button);
    form.append(hidden_details);

    timetable_url = '/timetable.cgi?period=' + default_period + '&class=' + default_class + '&keyt=' + keyt;
    $('#nav-exercises').attr('href', timetable_url);

    classes_container.append(form);
    identity_row.append(classes_container);


    ////////////////////////////////////////////////////////////////////////////
    // More CATE Links /////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////
    console.log(main_cate_table);
    links_tds = main_cate_table.find('tr td ul table:eq(9) tr td:nth-child(3)');
    grading_schema_href = $(links_tds[1]).find('a').attr('href');
    documentation_href = $(links_tds[2]).find('a').attr('href');
    late_sub_href = $(links_tds[3]).find('a').attr('href');
    proj_portal_href = $(links_tds[5]).find('a').attr('href');
    individual_record_href = $(links_tds[7]).find('a').attr('href');

    // Update Navigation
    $('#nav-grades').attr('href', individual_record_href);

    // Add Quicklinks
    quicklink_container = $('<div class="span4"/>');
    quicklink_list = $('<ul class="nav nav-tabs nav-stacked" />');
    quicklink_list.append('<li class="disabled"><a href="#"><div class="list-icon-container"><i class="icon-bar-chart"></i>&nbsp;</div><div class="list-text">Analytics</div></a></li>');
    quicklink_list.append('<li><a href="' + grading_schema_href + '"><div class="list-icon-container"><i class="icon-key"></i>&nbsp;</div><div class="list-text">Department Grading Schema</div></a></li>');
    quicklink_list.append('<li><a href="' + documentation_href + '"><div class="list-icon-container"><i class="icon-file-alt"></i>&nbsp;</div><div class="list-text">Documentation</div></a></li>');
    quicklink_list.append('<li><a href="' + late_sub_href + '"><div class="list-icon-container"><i class="icon-exclamation-sign"></i>&nbsp;</div><div class="list-text">Late Submissions/Extensions</div></a></li>');
    quicklink_list.append('<li class="disabled"><a href="#"><div class="list-icon-container"><i class="icon-briefcase"></i>&nbsp;</div><div class="list-text">Lecture Notes + Exercises Registration</div></a></li>');
    quicklink_list.append('<li><a href="' + proj_portal_href + '"><div class="list-icon-container"><i class="icon-lightbulb"></i>&nbsp;</div><div class="list-text">Projects Portal</div></a></li>');
    quicklink_list.append('<li class="disabled"><a href="#"><div class="list-icon-container"><i class="icon-magic"></i>&nbsp;</div><div class="list-text">Special Activities</div></a></li>');

    quicklink_container.append('<h1 class="section-header">Other Links</h1>');
    quicklink_container.append(quicklink_list);
    identity_row.append(quicklink_container);


    ////////////////////////////////////////////////////////////////////////////
    // Add a Footer ////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////
    footer_html =  '<footer class="footer">';
    footer_html += '    <div class="container">';
    footer_html += '        <p>';
    footer_html += '            Designed and Created by <a href="http://www.inspiredpixel.net">Peter Hamilton</a> ';
    footer_html += '            <a href="http://www.twitter.com/peterejhamilton"><i class="icon-twitter" /></a> ';
    footer_html += '            <a href="http://www.github.com/peterejhamilton"><i class="icon-github" /></a> ';
    footer_html += '        </p>';
    footer_html += '        <p>Help lessen the pain - <a href="#"><i class="icon-github-alt" /></a></p>';
    footer_html += '    </div>';
    footer_html += '</footer>';
    container.after(footer_html);


    ////////////////////////////////////////////////////////////////////////////
    // Scour the Earth of old CATE /////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////
    header_container.remove();
    main_cate_table.remove();
    $('hr').remove(); // Remove old HRs
    $('table:last').remove(); // Footer
})();
