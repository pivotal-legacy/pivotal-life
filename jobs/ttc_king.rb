require 'dotenv'

Dotenv.load

SCHEDULER.every '60s', first_in: 0 do
	response = JSON.parse(Net::HTTP.get(URI("https://myttc.ca/king_station.json")))
	stops = response['stops']

	northbound_timings = []
	southbound_timings = []

	stops.each do |item|
		if item['uri'] == 'king_station_northbound_platform'
			item['routes'][0]['stop_times'].each do |timing|
				northbound_timings.push(timing['departure_time'] + 'm')
			end

		elsif item['uri'] == 'king_station_southbound_platform'
			item['routes'][0]['stop_times'].each do |timing|
				southbound_timings.push(timing['departure_time'] + 'm')
			end
		end
	end

	send_event('ttc_king', { northbound: northbound_timings, southbound: southbound_timings })
end
