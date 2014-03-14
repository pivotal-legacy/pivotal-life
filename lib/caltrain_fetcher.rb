require 'nokogiri'

class CaltrainFetcher
  def initialize(token)
    url = "http://services.my511.org/Transit2.0/GetNextDeparturesByStopName.aspx?token=#{token}&agencyName=Caltrain&stopName=Palo%20Alto%20Caltrain%20Station"
    @data = fetch_data(url)
  end

  def fetch_data(url)
    response = Nokogiri::XML(Net::HTTP.get(URI(url)))
    response.css("DepartureTime").map do |departure_time|
      route = departure_time.ancestors("Route").attribute("Name").text
      direction = departure_time.ancestors("RouteDirection").attribute("Name").text.match(/NORTH/) ? :NB : :SB
      minutes = Integer(departure_time.text)
      Departure.new(direction, route, minutes)
    end
  end

  def data
    @data
  end

  class Departure < Struct.new(:direction, :type, :minutes); end
end
