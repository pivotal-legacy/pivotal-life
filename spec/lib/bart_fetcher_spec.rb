require 'spec_helper'
require 'webmock'
include WebMock::API

describe BartFetcher do
  let(:sf511_url) {'http://511.org/api'}
  let(:bart_fetcher) { BartFetcher.new(sf511_url) }

  before(:each) do
    stub_request(:get, sf511_url).to_return(:body => File.read('spec/fixtures/511_bart.xml'))
  end

  it 'has data' do
    expected = {
      'Concord' => [55],
      'Daly City' => [2,7,16],
      'Dublin Pleasanton' => [13,27,42],
      'Fremont' => [4,19,34],
      'Millbrae' => [12, 27, 42],
      'Pittsburg Bay Point' => [14, 30, 44],
      'Richmond' => [9, 22, 38],
      'SFO' => [4, 19, 34],
    }

    d = bart_fetcher.data
    expect(d).to eq(expected)
  end
end

