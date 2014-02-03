require 'nokogiri'

class MuniBusFetcher
  def initialize(token)
    @data = {}
    stop_codes = [13128, 13159, 13168, 13170, 13171, 14757, 15644, 15644, 15645, 15655, 15688, 15817]
    stop_codes.each do |stop_code|
      url = "http://services.my511.org/Transit2.0/GetNextDeparturesByStopCode.aspx?token=#{token}&stopCode=#{stop_code}"
      @data.merge! fetch_data(url)
    end
  end



  def data
    @data
  end


  private

  def fetch_data(url)
    data = {}
    xmlParsed = Nokogiri::XML(Net::HTTP.get(URI(url)))
    xmlParsed.xpath('/RTT/AgencyList/Agency/RouteList/Route').each do |route|
      stop = route.xpath('./RouteDirectionList/RouteDirection/StopList/Stop').attribute('name').value

      data[stop] ||= {}

      data[stop][route.attribute('Code').text] = route.xpath('./RouteDirectionList/RouteDirection/StopList/Stop/DepartureTimeList/DepartureTime').map do |time|
        Integer(time.text)
      end
    end
    data
  end

end
