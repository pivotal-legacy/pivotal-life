require 'dotenv'

Dotenv.load

latitude = ENV['NYC_LATITUDE'] || 40.740673
longitude = ENV['NYC_LONGITUDE'] || -73.994808
lat_long = [latitude, longitude]

SCHEDULER.every '1m' do
  stations = CitibikeFetcher.find(lat_long, 0.30)

  bike_counts = Hash.new({ value: 0 })
  stations.each do |station|
    bike_counts[station[:label]] = {
      label: station[:label],
      value: station[:availableBikes]
    }
  end

  send_event('citibikenyc', { items: bike_counts.values })
end
