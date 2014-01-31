require 'date'

class CalendarFetcher
  def initialize(url, name = '')
    events = []
    now = DateTime.now
    min = CGI.escape(now.to_s)

    next_sunday = (now.to_date + (7-now.to_date.wday)+1).to_datetime
    max = CGI.escape(next_sunday.to_s)
    url += "?singleevents=true&orderby=starttime&start-min=#{min}&start-max=#{max}"
    reader = Nokogiri::XML(open(url))
    reader.remove_namespaces!
    reader.xpath("//feed/entry").each do |e|
      title = e.at_xpath("./title").text
      content = e.at_xpath("./content").text
      when_node = e.at_xpath("./when")
      where_node_value = e.at_xpath("./where").attribute("valueString")
      events.push({title: title,
                   body: content ? content : "",
                   calendar: name,
                   where: where_node_value && where_node_value.text,
                   when_start_raw: when_node ? DateTime.iso8601(when_node.attribute('startTime').text).to_time.to_i : 0,
                   when_end_raw: when_node ? DateTime.iso8601(when_node.attribute('endTime').text).to_time.to_i : 0,
                   when_start: when_node ? DateTime.iso8601(when_node.attribute('startTime').text).to_time : "No time",
                   when_end: when_node ? DateTime.iso8601(when_node.attribute('endTime').text).to_time : "No time"
                  })
    end

    @data = events
  end

  def data
    @data
  end
end
