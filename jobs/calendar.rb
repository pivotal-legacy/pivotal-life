#!/usr/bin/env ruby
require 'open-uri'
require 'nokogiri'
require 'date'
require 'cgi'
require 'dotenv'

Dotenv.load

# Config
# make sure your URLs end with /full, not /simple (which is default)!
# ------

default_calendar_url = "http://www.google.com/calendar/feeds/en.usa%23holiday%40group.v.calendar.google.com/public/full"
calendar_url = ENV['EVENT_CALENDAR_URL'] || default_calendar_url

calendars = [{name: 'Events', url: calendar_url}]

events = Array.new

SCHEDULER.every '10m', :first_in => 0 do |job|
  events = Array.new
  min = CGI.escape(DateTime.now().to_s)
  max = CGI.escape((DateTime.now()+7).to_s)

  calendars.each do |calendar|
    url = calendar[:url]+"?singleevents=true&orderby=starttime&start-min=#{min}&start-max=#{max}"
    reader = Nokogiri::XML(open(url))
    reader.remove_namespaces!
    reader.xpath("//feed/entry").each do |e|
      title = e.at_xpath("./title").text
      content = e.at_xpath("./content").text
      when_node = e.at_xpath("./when")
      where_node = e.at_xpath("./where")
      events.push({title: title,
                   body: content ? content : "",
                   calendar: calendar[:name],
                   where: where_node.attribute("valueString").text,
                   when_start_raw: when_node ? DateTime.iso8601(when_node.attribute('startTime').text).to_time.to_i : 0,
                   when_end_raw: when_node ? DateTime.iso8601(when_node.attribute('endTime').text).to_time.to_i : 0,
                   when_start: when_node ? DateTime.iso8601(when_node.attribute('startTime').text).to_time : "No time",
                   when_end: when_node ? DateTime.iso8601(when_node.attribute('endTime').text).to_time : "No time"
      })
    end
  end

  events.sort! { |a,b| a[:when_start_raw] <=> b[:when_start_raw] }
  events = events.slice!(0,15) # 15 elements is probably enough...

  send_event('calendar_events', { events: events })
end

SCHEDULER.every '1m', :first_in => 0 do |job|
  events_tmp = Array.new(events)
  events_tmp.delete_if{|event| DateTime.now().to_time.to_i>=event[:when_end_raw]}


  if events_tmp.count != events.count
    events = events_tmp
    send_event('calendar_events', { events: events })
  end
end
