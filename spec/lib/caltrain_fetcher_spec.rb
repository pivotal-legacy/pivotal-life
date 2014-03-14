require 'spec_helper'
require 'webmock'
include WebMock::API

describe CaltrainFetcher do
  let(:token) { "random-letters" }
  let(:url) {"http://services.my511.org/Transit2.0/GetNextDeparturesByStopName.aspx?token=#{token}&agencyName=Caltrain&stopName=Palo%20Alto%20Caltrain%20Station"}
  let(:caltrain_fetcher) { CaltrainFetcher.new(token) }

  before(:each) do
    stub_request(:get, url).to_return(:body => File.read('spec/fixtures/caltrain_palo_alto.xml'))
  end

  it 'collects the caltrain data for Palo Alto' do
    expected = [
      CaltrainFetcher::Departure.new(:SB, "LOCAL", 76),
      CaltrainFetcher::Departure.new(:SB, "LOCAL", 7),
      CaltrainFetcher::Departure.new(:NB, "LOCAL", 41)
    ]
    expect(caltrain_fetcher.data).to eq(expected)
  end
end
