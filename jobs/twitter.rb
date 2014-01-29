require 'cgi'
require 'twitter'
require 'dotenv'

Dotenv.load

client = Twitter::REST::Client.new do |config|
  config.consumer_key        = ENV['TWITTER_CONSUMER_KEY']
  config.consumer_secret     = ENV['TWITTER_CONSUMER_SECRET']
  config.access_token        = ENV['TWITTER_OAUTH_TOKEN']
  config.access_token_secret = ENV['TWITTER_OAUTH_SECRET']
end

user_name = 'spilth'
list_name = 'pivotal-life'

SCHEDULER.every '10m', :first_in => 0 do |job|
  begin
    tweets = client.list_timeline(user_name, list_name)

    if tweets
      tweets.map! do |tweet|
        { name: CGI.unescapeHTML(tweet.user.name), body: CGI.unescapeHTML(tweet.text), avatar: tweet.user.profile_image_url_https }
      end
      send_event('twitter_mentions', comments: tweets)
    end
  rescue Twitter::Error
    puts "\e[33mFor the twitter widget to work, you need to put in your twitter API keys in the jobs/twitter.rb file.\e[0m"
  end
end
