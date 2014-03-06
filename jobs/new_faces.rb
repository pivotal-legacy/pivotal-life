require 'open-uri'

SCHEDULER.every '1d', first_in: 0 do
  pivots_user_email = ENV['PIVOTS_EMAIL'] || 'PIVOTS_USER_EMAIL_MISSING'
  pivots_auth_token = ENV['PIVOTS_AUTH_TOKEN'] || 'PIVOTS_AUTH_TOKEN_MISSING'
  pivots_datasource = "https://pivotalpivots2.herokuapp.com/api/users.json?email=#{URI::encode(pivots_user_email)}&authentication_token=#{URI::encode(pivots_auth_token)}"

  send_event('new_faces', {
      new_faces: NewFacesFetcher.new(pivots_datasource)['San Francisco'],
      random_faces: RandomFacesFetcher.new(pivots_datasource)['San Francisco']
  })
end
