configure :development, :test do
  set :asset_cache_for, 1 # 1 second
end

configure :production do
  set :asset_cache_for, 60*60*24 # 1 day
end
