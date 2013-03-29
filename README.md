# Classy CATE

CATE, without ~~the~~ as much hurt.

![Classy CATE](https://f.cloud.github.com/assets/510845/117032/1bde6e48-6c18-11e2-9452-0a37d6cd08d6.png "Classy CATE")


## Installation
  - [Chrome](https://www.google.com/intl/en/chrome/browser/)
    - Install [TamperMonkey](https://chrome.google.com/webstore/detail/tampermonkey/dhdgffkkebhmkfjojejmpbldmpobfkfo?hl=en)
    - Visit http://classy-cate.herokuapp.com/classy-cate.user.js
    - Agree/Install
    - Alternatively, install it as a Chrome user script
  - [Firefox](http://www.mozilla.org/en-US/firefox/new/)
    - Install [Greasemonkey](https://addons.mozilla.org/en-US/firefox/addon/greasemonkey/)
    - Visit http://classy-cate.herokuapp.com/classy-cate.user.js
    - Agree/Install

- TamperMonkey is a great chrome extension for this. (Thanks to @vahokif)
- [Allow Third party Chrome Scripts](http://solidsprite.com/2012/08/how-to-install-third-party-userscripts-in-chrome-mac-os-x/)
- [Enabling 3rd Party Chrome user scripts](http://userscripts.org/topics/113176) (OSX)

## Rough TODO List (Please Help)

- **Make Timetable Page smoother/prettier**
- Scrub last vestige of CATE from homepage - the favicon! Use [this](http://stackoverflow.com/questions/260857/changing-website-favicon-dynamically/260876#260876)
- Non-Undergrads may experience missing/broken links. I have no idea.

## Ideas

- Timetable page
  - Work on condensed version for dashboard
  - Notify of upcoming deadlines
  - Aggregate links to notes, exercises without jumping around a huge
  table, possibly include a download all function?

## Development

To develop and help improve classy-cate, do the following:

1. Run the server with `shotgun -p 4567 web.rb`
2. Add whatever other local server assets you wish to the
   classy_cate.user_testing.js file
3. Install your modified `classy-cate.user.js` as an Userscript/Greasemonkey extension in Chrome/Firefox.
4. Modify `views/classy_cate.coffee.erb` and `views/classy_cate.less` to
   add/modify functionality as you wish!

## Want to help, but don't have a clue?

Hopefully some first years will want to contribute to this project. If
you're one of them, but are put off by what seems like a stupid amount
of complexity just to get it working, then have a look at [this](https://github.com/lmj112/classy-cate/wiki/Getting-off-the-Ground-for-Development) page to get you started.


## References

- [jQuery](http://api.jquery.com/jQuery/) as a Javascript Framework
- [Twitter Bootstrap](http://twitter.github.com/bootstrap/) for pretty CSS
- [Font Awesome](http://fortawesome.github.com/Font-Awesome/) for a breadth of nice scalable icons
- [jQuery Timeline](http://github.com/lmj112/jQueryTimeline/) for the
exercises page timelines
