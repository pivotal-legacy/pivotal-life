# :first_in sets how long it takes before the job is first run. In this case, it is run immediately
SCHEDULER.every '1m', :first_in => 0 do |job|
  muni_bus_fetcher = MuniBusFetcher.new(ENV['SF511_AUTH_TOKEN'])
  send_event('muni_bus', {data: muni_bus_fetcher.data })
end
