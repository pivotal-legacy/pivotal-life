require 'spec_helper'
require 'timecop'
require 'webmock'
include WebMock::API

describe NewFacesFetcher do
  let(:pivots_url) {'http://pivots/url'}

  before(:each) do
    Timecop.travel(Time.local(2013, 5, 25))
    stub_request(:get, pivots_url).to_return(:body => File.read('spec/fixtures/pivots_users.json'))
  end

  describe '#[]' do
    let(:fetcher) { NewFacesFetcher.new(pivots_url) }

    it 'returns new Pivots from a location' do
      expect(fetcher['San Francisco']).to match_array([{first_name: 'Eno', last_name: 'Compton', photo_url: 'enos_picture'}])
      expect(fetcher['Toronto']).to match_array([{first_name: 'Notin', last_name: 'SF', photo_url: 'notinsf_picture'}])
    end
  end
end
