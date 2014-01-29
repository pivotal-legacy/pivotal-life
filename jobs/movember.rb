SCHEDULER.every '1h', first_in: 0 do
  movember_teams = JSON.parse(ENV['MOVEMBER_TEAM_IDS'] || '[]')
  fetched_values = movember_teams.map { |team_number| MovemberFetcher.new(team_number).fetch }
  send_event('movember', { items: fetched_values })
end
