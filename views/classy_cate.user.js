// ==UserScript==
// @name         CATE 2.0
// @author       Pater Hamilton
// @description  CATE Hurts eyes. This makes it hurt them less.
// @version 0.1
// @match https://cate.doc.ic.ac.uk/*
// ==/UserScript==

function main() {
    console.log("Giving CATE a makeover");

    // Let's Bootstrap this shizzle. Files from http://www.bootstrapcdn.com/?v=01282013154951
    $('head').append('<link rel="stylesheet" href="//netdna.bootstrapcdn.com/twitter-bootstrap/2.2.2/css/bootstrap-combined.min.css" type="text/css" />');
    $('head').append('<link rel="stylesheet" href="//netdna.bootstrapcdn.com/font-awesome/3.0/css/font-awesome.css" type="text/css" />');
    $('head').append('<link rel="stylesheet" href="https://classy-cate.herokuapp.com/classy-cate.css" type="text/css" />');

    $('head').append('<script type="text/javascript" src="//netdna.bootstrapcdn.com/twitter-bootstrap/2.2.2/js/bootstrap.min.js"></script>');
    $('head').append('<script type="text/javascript" src="https://classy-cate.herokuapp.com/classy-cate.js"></script>');
}

// a function that loads jQuery and calls a callback function when jQuery has finished loading
function addJQuery(callback) {
  var script = document.createElement("script");
  script.setAttribute("src", "//ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js");
  script.addEventListener('load', function() {
    var script = document.createElement("script");
    // script.textContent = "window.jQ=jQuery.noConflict(true);(" + callback.toString() + ")();";
    script.textContent = "(" + callback.toString() + ")();";
    document.body.appendChild(script);
  }, false);
  document.body.appendChild(script);
}

// load jQuery and execute the main function
addJQuery(main);
