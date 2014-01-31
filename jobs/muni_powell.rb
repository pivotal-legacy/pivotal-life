SCHEDULER.every '60s', first_in: 0 do
  muni_powell_client = MuniPowellFetcher.new(ENV['SF511_AUTH_TOKEN'])
  send_event('muni_powell', { data: muni_powell_client.data })
end
