configure :development, :test do
  set :asset_cache_for, 1 # 1 second
  set :cc_css_url, 'https://localhost:4567/classy-cate.css'
  set :tl_css_url, 'https://localhost:4567/timeline.css'
end

configure :production do
  set :asset_cache_for, 60*60*24 # 1 day
  set :cc_css_url, 'https://classy-cate.herokuapp.com/classy-cate.css'
  set :tl_css_url, 'https://classy-cate.herokuapp.com/timeline.css'
end
