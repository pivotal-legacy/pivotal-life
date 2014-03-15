SCHEDULER.every '30s', first_in: 0 do
  data = CaltrainFetcher.new(ENV['SF511_AUTH_TOKEN']).data.map(&:to_h)
  send_event('caltrain', { data: data })
end
