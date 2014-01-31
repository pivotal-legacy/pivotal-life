url = "http://services.my511.org/Transit2.0/GetNextDeparturesByStopName.aspx?token=#{ENV['SF511_AUTH_TOKEN']}&stopName=Powell+St.+(SF)&agencyName=BART"

SCHEDULER.every '60s', first_in: 0 do
  bart_client = BartFetcher.new(url)
  send_event('bart', { data: bart_client.data })
end
