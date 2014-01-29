require 'json'

class NewFacesFetcher
  def initialize(pivots_url)
    @pivots = JSON.parse(Net::HTTP.get(URI(pivots_url)))
  end

  def [](location)
    @pivots.select do |pivot|
      pivot['location_name'] == location && Time.at(pivot['started_on']) > Time.now - 2.weeks
    end.map do |pivot|
      {
        first_name: pivot['first_name'],
        last_name: pivot['last_name'],
        photo_url: pivot['photo_url']
      }
    end
  end
end
