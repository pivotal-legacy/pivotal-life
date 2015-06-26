class ForecastFetcher
  # Unit Format
  # "us" - U.S. Imperial
  # "si" - International System of Units
  # "uk" - SI w. windSpeed in mph
  DEFAULT_LOCATIONS = {
    sf: { lat: 40.740673, lon: -73.994808, units: 'us', temp_unit: :f },
    pa: { lat: 37.394555, lon: -122.148039, units: 'us', temp_unit: :f },
    london: { lat: 51.5072, lon: 0.1275, units: 'uk', temp_unit: :c },
    nyc: { lat: 40.740673, lon: -73.994808, units: 'us', temp_unit: :f, alt_temp_unit: :c },
    to: { lat: 43.649932, lon: -79.375756, units: 'si', temp_unit: :c },
    boulder: { lat: 40.0149900, lon: -105.2705500, units: 'us', temp_unit: :f},
    denver: { lat: 39.7392, lon: -104.9903, units: 'us', temp_unit: :f}
  }

  def initialize(api_key, locations = DEFAULT_LOCATIONS)
    @api_key = api_key
    @locations = locations
    @location_fetcher = Forecast::LocationFetcher.new(api_key)
  end

  def data
    memo = {}
    locations.each_pair do |key, location|
      response = location_fetcher.location_data(location)
      formatter = Forecast::LocationResponseFormatter.new(location, response)
      memo[key]= formatter.data
    end
    memo
  end

  private

  attr_reader :api_key, :locations, :location_fetcher
end
