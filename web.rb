require 'sinatra'
require 'json'
require 'git'
require 'heroku'
require 'coffee-script'
require 'less'
require 'dalli'

# Default 10 minute cache
set :cache, Dalli::Client.new(nil, {:expires_in => 60*10})

get '/' do
  redirect "https://github.com/PeterHamilton/classy-cate#classy-cate"
end

# Asset Serving
get '/classy-cate.user.js' do
  send_file('views/classy_cate.user.js')
end

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

get '/classy-cate.css' do
  begin
    css = settings.cache.get('classy-cate-css')
    if css.nil?
      logger.info "Caching Classy CATE CSS"
      css = less :classy_cate
      settings.cache.set('classy-cate-css', css)
    end
  rescue *[Dalli::RingError, Dalli::NetworkError]
    css = less :classy_cate
  end
  css
end

# Auto Deploy Methods
get '/public_key' do
  require_relative 'lib/init'
  ::CURRENT_SSH_KEY
end

get '/status' do
  require_relative 'lib/init'
  c = GitPusher.local_state(ENV['GITHUB_REPO'])
  "SHA: #{c.sha} | Date: #{c.date}"
end

get '/nuke-repos' do
  require_relative 'lib/init'
  `rm -r repos`
  "nuked!"
end

get '/force-push' do
  require_relative 'lib/init'
  GitPusher.deploy(ENV['GITHUB_REPO'])
  "Success!"
end

post '/post-receive' do
  require_relative 'lib/init'
  data = JSON.parse(params[:payload])
  # if data["repository"]["private"]
  #   "freak out"
  # end
  url = data["repository"]["url"]
  GitPusher.deploy(url)
  begin
    logger.info "Flushing the Cache Post-Deploy"
    settings.cache.flush_all
  rescue Dalli::NetworkError
  end
  "Success!"
end
