require 'nokogiri'

class BartFetcher
  def initialize(url)
    xmlResponse = Net::HTTP.get(URI(url))

    xmlParsed = Nokogiri::XML(xmlResponse)

    @data = {}
    xmlParsed.xpath('/RTT/AgencyList/Agency/RouteList/Route').each do |route|
      data[route.attribute('Name').text.gsub('SF Airport','SFO')] = route.xpath('./StopList/Stop/DepartureTimeList/DepartureTime').map do |time|
        Integer(time.text)
      end
    end

    @data.select! do |name, times|
      times.size > 0
    end
  end

  def data
    @data
  end
end
