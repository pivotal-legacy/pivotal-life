require 'nokogiri'
require 'net/http'

class GoTrainStatusFetcher
  URL = "http://www.gotransit.com/publicroot/en/updates/servicestatus.aspx?tab=1"

  def initialize()
    @data = Net::HTTP.get(URI(URL))
  end

  def status_table
    @data.match(/(<table.*?<\/table>)/).to_s
  end
end
