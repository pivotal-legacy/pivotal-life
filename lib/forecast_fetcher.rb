class ForecastFetcher
  # Unit Format
  # "us" - U.S. Imperial
  # "si" - International System of Units
  # "uk" - SI w. windSpeed in mph
  DEFAULT_LOCATIONS = {
    sf: { lat: 40.740673, lon: -73.994808, units: 'us' },
    pa: { lat: 37.394555, lon: -122.148039, units: 'us' },
    london: { lat: 51.5072, lon: 0.1275, units: 'uk' },
    nyc: { lat: 40.740673, lon: -73.994808, units: 'us' },
    to: { lat: 43.649932, lon: -79.375756, units: 'si'}
  }

  def initialize(key, locations = DEFAULT_LOCATIONS)
    @key = key
    @locations = locations
  end

  def data
    memo = {}
    @locations.each_pair do |key, location|
      memo[key]= fetch_for_location(location)
    end
    memo
  end

  def fetch_for_location(location)
    http = Net::HTTP.new("api.forecast.io", 443)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_PEER
    lat = location[:lat]
    lon = location[:lon]
    units = location[:units]

    response = http.request(Net::HTTP::Get.new("/forecast/#{@key}/#{lat},#{lon}?units=#{units}"))
    forecast = JSON.parse(response.body)
    data = {
      current_temp:  forecast["currently"]["temperature"].round,
      current_icon: forecast["currently"]["icon"],
      current_desc: forecast["currently"]["summary"],
      apparent_temp: forecast["currently"]["apparentTemperature"].round,
      later_desc: forecast["hourly"]["summary"],
      later_icon: forecast["hourly"]["icon"]
    }

    if forecast["minutely"]  # sometimes this is missing from the response.  I don't know why
      data.merge!({
        next_desc: forecast["minutely"]["summary"],
        next_icon: forecast["minutely"]["icon"]
      })
    else
      puts "Did not get minutely forecast data again"
      data.merge!({
        next_desc: "No data",
        next_icon:  ""
      })
    end
    data
  end
end
