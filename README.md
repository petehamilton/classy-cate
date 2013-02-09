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

- **Timetable page**
- **Grades Page**
- Scrub last vestige of CATE from homepage - the favicon! Use [this](http://stackoverflow.com/questions/260857/changing-website-favicon-dynamically/260876#260876)
- Non-Undergrads may experience missing/broken links. I have no idea.
- Refactor code in functions (couldn't until now)

## Ideas

- Scrape Timetable page
  - Put below current interface
  - Notify of upcoming deadlines
  - Aggregate links to notes, exercises without jumping around a huge table

## Development

To develop and help improve classy-cate, do the following:

1. Run the server with `thin start --ssl`
2. Modify `classy-cate.user.js` js/css references to refer to the local python server e.g. `https://raw.github.com/PeterHamilton/classy-cate/master/ -> https://localhost:3000/classy-cate.css`
3. Install your modified `classy-cate.user.js` as an Userscript/Greasemonkey extension in Chrome/Firefox.
4. Modify `views/classy-cate.js` and `views/classy-cate.less`


## References

- [jQuery](http://api.jquery.com/jQuery/) as a Javascript Framework
- [Twitter Bootstrap](http://twitter.github.com/bootstrap/) for pretty CSS
- [Font Awesome](http://fortawesome.github.com/Font-Awesome/) for a breadth of nice scalable icons
