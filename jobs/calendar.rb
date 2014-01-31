#!/usr/bin/env ruby
require 'open-uri'
require 'nokogiri'
require 'date'
require 'cgi'
require 'dotenv'

Dotenv.load

# make sure your URLs end with /full, not /simple or /basic (which is default!)
default_calendar_url = 'http://www.google.com/calendar/feeds/en.usa%23holiday%40group.v.calendar.google.com/public/full'
calendar_url = ENV['EVENT_CALENDAR_URL'] || default_calendar_url

events = []

SCHEDULER.every '10m', :first_in => 0 do |job|
  events = CalendarFetcher.new(calendar_url).data
  events.sort! { |a,b| a[:when_start_raw] <=> b[:when_start_raw] }
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
