require 'json'

class NewFacesFetcher
  def initialize(pivots_url)
    @pivots = JSON.parse(Net::HTTP.get(URI(pivots_url)))
  end

  def [](location)
    @pivots.select do |pivot|
      pivot['location_name'] == location
    end.sort do |p1, p2|
      p2['started_on'] <=> p1['started_on']
    end.map do |pivot|
      {
        first_name: pivot['first_name'],
        last_name: pivot['last_name'],
        photo_url: pivot['photo_url'],
        title: pivot['title']
      }
    end[0..9]
  end
end
