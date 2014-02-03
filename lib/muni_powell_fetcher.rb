require 'nokogiri'

class MuniPowellFetcher
  def initialize(token)
    inbound_url = "http://services.my511.org/Transit2.0/GetNextDeparturesByStopCode.aspx?token=#{token}&stopcode=15417"
    outbound_url = "http://services.my511.org/Transit2.0/GetNextDeparturesByStopCode.aspx?token=#{token}&stopcode=16995"

  @data = {
      inbound: fetch_data(inbound_url),
      outbound: fetch_data(outbound_url)
    }

    @data.select! do |name, times|
      times.size > 0
    end
  end

  def fetch_data(url)
    data = {}
    xmlParsed = Nokogiri::XML(Net::HTTP.get(URI(url)))
    xmlParsed.xpath('/RTT/AgencyList/Agency/RouteList/Route').each do |route|
      data[route.attribute('Code').text] = route.xpath('./RouteDirectionList/RouteDirection/StopList/Stop/DepartureTimeList/DepartureTime').map do |time|
        Integer(time.text)
      end
    end
    data
  end

  def data
    @data
  end
end
