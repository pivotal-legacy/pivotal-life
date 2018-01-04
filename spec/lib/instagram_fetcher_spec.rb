require 'spec_helper'
require 'webmock'
include WebMock::API

describe InstagramFetcher do
  let(:user_id) { 2021019852 }
  let(:pivotal_url) { "https://www.instagram.com/graphql/query/?query_id=17888483320059182&variables=%7B%22id%22%3A%22#{user_id}%22%2C%22first%22%3A100%7D" }

  describe 'initializtion' do
    before do
      stub_request(:get, pivotal_url).to_return(:body => File.read('spec/fixtures/instagram_media.json'))
    end

    it 'should grab a list of image links' do
      image_urls =  InstagramFetcher.new(user_id).image_urls
      puts image_urls
      expect(image_urls.count).to eq(68)
      expect(image_urls).to eq(image_urls.uniq)
    end
  end
end
