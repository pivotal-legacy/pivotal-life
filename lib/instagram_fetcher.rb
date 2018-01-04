class InstagramFetcher
  def initialize(user_id)
    url = "https://www.instagram.com/graphql/query/?query_id=17888483320059182&variables=%7B%22id%22%3A%22#{user_id}%22%2C%22first%22%3A100%7D"
    @data = Net::HTTP.get(URI(url))
  end

  def image_urls
    @data.scan(/src\"\:\ "(.*?\/s[6][4][0].*?)\"/).flatten.select { |m| !m.include?(',') }.uniq
  end
end
