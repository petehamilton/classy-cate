require 'sinatra'
require 'json'
require 'git'
require 'heroku'
require 'coffee-script'

get '/' do
  "Static Asset Server for Classy CATE"
end

# Asset Serving
get '/classy-cate.user.js' do
  send_file('classy-cate.user.js')
end

get '/classy-cate.js' do
  coffee :classy_cate
end

get '/classy-cate.css' do
  less :classy_cate
end

# Auto Deploy Methods
get '/public_key' do
  ::CURRENT_SSH_KEY
end

get '/status' do
  c = GitPusher.local_state(ENV['GITHUB_REPO'])
  "SHA: #{c.sha} | Date: #{c.date}"
end

get '/nuke-repos' do
  `rm -r repos`
  "nuked!"
end

get '/force-push' do
  GitPusher.deploy(ENV['GITHUB_REPO'])
  "Success!"
end

post '/post-receive' do
  data = JSON.parse(params[:payload])
  # if data["repository"]["private"]
  #   "freak out"
  # end
  url = data["repository"]["url"]
  GitPusher.deploy(url)
  "Success!"
end

require_relative 'lib/init'
