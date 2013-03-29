# Default 10 minute cache
set :cache, Dalli::Client.new(nil, {:expires_in => 60*60*24})

def get_cache(index, timeout, &block)
  begin
    result = settings.cache.get(index)
    if result.nil?
      result = block.call
      puts "CACHE: Setting #{index}"
      settings.cache.set(index, result, timeout)
    else
      puts "CACHE: Retrieving #{index}"
    end
  rescue *[Dalli::RingError, Dalli::NetworkError]
    puts "CACHE: Failed #{index}"
    result = block.call
  end
  return result
end
