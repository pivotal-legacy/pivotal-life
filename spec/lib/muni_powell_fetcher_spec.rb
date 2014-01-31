require 'spec_helper'
require 'webmock'
include WebMock::API

describe MuniPowellFetcher do
  let(:token) {'tok'}
  let(:inbound_url) {"http://services.my511.org/Transit2.0/GetNextDeparturesByStopCode.aspx?token=#{token}&stopcode=15417"}
  let(:outbound_url) {"http://services.my511.org/Transit2.0/GetNextDeparturesByStopCode.aspx?token=#{token}&stopcode=16995"}
  let(:muni_powell_fetcher) { MuniPowellFetcher.new(token) }

  before(:each) do
    stub_request(:get, inbound_url).to_return(:body => File.read('spec/fixtures/511_muni_powell.xml'))
    stub_request(:get, outbound_url).to_return(:body => File.read('spec/fixtures/511_muni_powell2.xml'))
  end

  it 'has data' do
    expected = {
      inbound: {
        'J' => [2,24,31],
        'KT' => [13,23,28],
        'L' => [2,5,17],
        'M' => [3,37],
        'N' => [4,52,63]
      },
      outbound: {
        'J' => [6,11,33],
        'KT' => [7,18],
        'L' => [2,6,8],
        'M' => [5,11,13],
        'N' => [16,26,36]
      }
    }

    d = muni_powell_fetcher.data
    expect(d).to eq(expected)
  end
end
