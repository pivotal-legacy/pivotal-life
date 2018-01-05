require 'net/https'

SCHEDULER.every '5m', :first_in => 0 do |job|
  table = GoTrainStatusFetcher.new().status_table
  send_event('go_train_status', statusTable: table)
end
