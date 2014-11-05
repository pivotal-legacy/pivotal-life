require 'dotenv'
require 'yelp'

Dotenv.load

yelp_client = Yelp::Client.new({
  consumer_key: ENV['YELP_CONSUMER_KEY'],
  consumer_secret: ENV['YELP_CONSUMER_SECRET'],
  token: ENV['YELP_AUTH_TOKEN'],
  token_secret: ENV['YELP_AUTH_SECRET']
})

places = YAML.load(File.read('to_lunchplaces.yml'))['places']

SCHEDULER.every '30s', first_in: 0 do
  current_place = places.sample
  data = { place: current_place }
  data[:rating] = "#{yelp_client.business(current_place['yelp_biz']).rating}/5"

  if current_place['distance'] < 3
    data['wittyremark'] = "Come on, it's soo close!"
  elsif current_place['distance'] < 8
    data['wittyremark'] = "Pretty close... maybe not in the winter."
  else
    data['wittyremark'] = "Don't miss your 1pm meeting!"
  end
  send_event('lunch_places_to', data)
end
