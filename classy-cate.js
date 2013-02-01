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

    navbar_branding = $('<a class="brand" href="/">CATE <span id="cate-version">X</span></a>');
    navbar_inner.append(navbar_branding);
    navbar_inner.append(navbar_links);
    navbar_inner.append(year_dropdown_container);
    year_dropdown_container.append(year_dropdown);

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
    // Add nicer year selection ////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////
    classes_container = $('<div class="span4"/>');
    classes_container.append('<h1 class="section-header">Exercise Timetable</h1>');
    classes_container.append(main_cate_table.find('form:first'));
    identity_row.append(classes_container);


    ////////////////////////////////////////////////////////////////////////////
    // More CATE Links /////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////
    links_tds = main_cate_table.find('tr td ul table:eq(3) tr td:nth-child(3)');
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
    footer_html += '        <p>Designed and Created by <a href="http://www.inspiredpixel.net">Peter Hamilton</a> ';
    footer_html += '<a href="http://www.twitter.com/peterejhamilton"><i class="icon-twitter" /></a> ';
    footer_html += '<a href="http://www.github.com/peterejhamilton"><i class="icon-github" /></a> ';
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
