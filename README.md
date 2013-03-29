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
of complexity just to get it working, then listen in closely and you
should be able to go from there.

### Standard Running Procedure

This project currently relies on either tampermonkey or greasemonkey to
inject the correct scripts at the right time. Now, in normal running, a
user will have installed the js-vanilla userscript located in the views
folder, which is a set of instructions for *monkey to process should it
fit the preconitions in the file header (read, on cate url).

Once the match has been made *monkey fires up the user script which will
process the javascript inside it. This adds classy-cates files into the
html markup of the current page and allows all the backstage trickery
that lets cate get her facelift. Heroku is used to supply the scripts
for a few reasons (that I can only speculate. Guessing free & github
integration?)

### Running for Development

Now this is where a few of you would probably find yourself having
problems. I'd never encountered ruby on rails before I saw this repo so I know
exactly what you're feeling, but it's nothing too complex.

Rails is a ruby gem that serves up site assets given certain url
requests. If you look inside the web.rb file at the root of the
directory then you should find lots of things like::

    get '/classy-cate.user.js' do
        send_file('views/classy_cate.user.js')
    end

All this says is on the server being asked for the address
`server_location/classy-cate.user.js`, deliver the file
`views/classy_cate.user.js`. Simple stuff right? And I know exactly what
the next question is.

### What the hell is this?::

    get '/classy-cate.js' do
        begin
            js = settings.cache.get('classy-cate-js')
            if js.nil?
                logger.info "Caching Classy CATE JS"
                js = coffee(erb(:"classy_cate.coffee"))
                settings.cache.set('classy-cate-js', js)
            end
            rescue *[Dalli::RingError, Dalli::NetworkError]
                js = coffee(erb(:"classy_cate.coffee"))
        end
        js
    end

Well this looks a bit worse than that piece did. The real source of
confusion here for most is going to be that classy-cate.js doesn't
actually even exist. Anywhere. Not in that repository you're poking
round, or online. That's because everything here is in Coffeescript, a
layer over javascript that requires compiling to vanilla js.

That line `js = coffee(erb(:"classy_cate.coffee"))` is the call to say
"grab me the file classy_cate.coffee, run this ruby script on it (that's
down to the erb call) and use coffee to compile it to javascript. On
finishing, store this into the variable js". All the rest is just about
caching the file so you don't need to refetch it if it's already there.
Should be pretty easy to decode. 

So now you know why the files you're looking for aren't there, but what
makes them materialise?

### Ruby and Gemfiles

My intended audience for this excerpt knows absolutely nothing about
ruby on rails, coffeescript or any sort of server framework. As such,
you probably have no idea how to get this thing off the ground and
supplying the files you think the system needs.

First off, you need ruby. Please, if you don't have that, install it
now. Without it you're done. While you're there read up a bit about gems
and the like, then quickly come back here. Now to continue, the current
distributions gem requirements are located inside the Gemfiles included
in the repo. So before you do anything else, run::

    bundle install

from the root directory of the repo. This automates the installation of
all the required gems with the specified versions. Once this is
complete, we should be able to move on to actually starting the local
server.

### The local server

To develop for the repo, it's ideal that you set up a local server in
order to have your files served as you move through cate. At the moment,
heroku is the server that the scripts access for all their resources.
Heroku sits there, waits for contact and based ont he web.rb file
returns the correct file for each request. What we need is to simulate
heroku on our local machine.

There are various solutions for this, and I'm sure some will disagree
but I found the most stable gem for this purpose was shotgun. As such,
I'd advice you give that one a go before anything else, though it would
seem that thin is the recommended.::

    shotgun -p 4567 web.rb

Run this from the repos root and it should start a shotgun instance,
located at localhost:4567. This means you now have a server running on
your computer, a piece of software waiting for contact via a request on
localhost @ port 4567.

This means you can now happily ask localhost:4567 for any of the paths
included in the web.rb file and it should serve them up pretty nicely.

### The testing userscript

So now you know how it works, you should realise that somewhere you'll
need to notify the scripts that it's meant to get all it's stuff from
the localhost rather than heroku. Well the `classy_cate.user.js` script
is the one you'd have to modify, that or just use the
`classy_cate.user_testing.js` file that has the links already modified.
So assuming you change everything from heroku to the localhost on port
4567, then install the script into firefox/chrome, then everything
should be golden!

## Basic Explaination of Filestructure

The file structure is shown below, with short explainations as to what
each file does if it pertains to shallow development.::

    classy-cate
    |- config.ru  (specify sinatra as the server)
    |- Gemfile    (both this and the Gemfile.lock to specify required gems)
    |- Gemfile.lock
    |- lib  -+- git.rb
    |        |- heroku.rb
    |        +- init.rb
    |- Procfile
    |- README.md 
    |- views -+- classy_cate.coffee.erb     (the main script)
    |         |- classy_cate.less           (a condensed css file)
    |         |- classy_cate.user.js        (the *monkey production usrsrpt)
    |         |- classy_cate.user_testing.js     (testing usrscrpt)
    |         |- grades_page.haml           (all layouts for each page are
    |         |- grading_schema.haml         formed by compiling haml template
    |         |- layout.haml                 files. Much like markdown, just
    |         |- exercises_page.haml         a cleaner version of html)
    |         |- main_page.haml
    |         |- timeline.css             (css for the timeline plugin)
    |         +- timeline.coffee.erb      (coffeescript implementation of the
    |                                      timeline plugin)
    +- web.rb   (file that deals with asset serving)

## References

- [jQuery](http://api.jquery.com/jQuery/) as a Javascript Framework
- [Twitter Bootstrap](http://twitter.github.com/bootstrap/) for pretty CSS
- [Font Awesome](http://fortawesome.github.com/Font-Awesome/) for a breadth of nice scalable icons
- [jQuery Timeline](http://github.com/lmj112/jQueryTimeline/) for the
exercises page timelines
