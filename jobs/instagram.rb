require 'net/https'

SCHEDULER.every '1h', :first_in => 0 do |job|
  image_urls = InstagramFetcher.new(2021019852).image_urls
  send_event('instagram', photo_urls: image_urls)
end
