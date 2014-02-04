require 'spec_helper'
require 'webmock'
include WebMock::API

describe MuniBusFetcher do

  let(:token) {'85ba60c5-3fcd-49c1-9616-241f0a54f6cb'}
  let(:fetcher) {MuniBusFetcher.new(token)}
  let(:stop_codes) {[13128, 13159, 13160, 13168, 13170, 13171, 14757, 15644, 15644, 15645, 15655, 15688, 15817]}

  before do
    stop_codes.each do |stop_code|
      url = "http://services.my511.org/Transit2.0/GetNextDeparturesByStopCode.aspx?stopCode=#{stop_code}&token=#{token}"
      fixture = "spec/fixtures/511_stopcode_#{stop_code}.xml"
      stub_request(:get, url).to_return(:body => File.read(fixture))
    end
  end

  it 'gets the data and removes routes with no times' do
    fetcher.data.should == {
      "3rd St  and  Howard St" => {"30"=>[8, 14], "45"=>[10, 22, 34], "8X"=>[3, 25, 31]},
      "5th St  and  Folsom St" => {"27"=>[15, 24, 39], "30"=>[10, 11, 13], "45"=>[6, 18, 28], "8X"=>[3, 13, 30]},
      "5th St  and  Howard St" => {"27"=>[15, 24, 39], "30"=>[9, 11, 12], "45"=>[5, 17, 28], "8X"=>[2, 12, 29]},
      "Geary Blvd  and  Powell St" => {"38"=>[3, 10, 16], "38L"=>[2, 8, 13]},
      "Market Bet 5th  and  4th St" => {"5"=>[6, 13, 29], "71"=>[4, 13, 23]},
      "Market St  and  5th St" => {"21"=>[10, 22, 34], "31"=>[6, 18, 33], "6"=>[13, 20, 31], "9"=>[9, 22, 29], "9L"=>[18, 30, 43], "F"=>[3, 11, 17]},
      "Market St  and  5th St North" => {"6"=>[3, 15, 27], "71"=>[8, 19, 31], "9"=>[2, 13, 37], "9L"=>[16, 20, 44], "F"=>[2, 3, 7]},
      "Market St  and  Powell St" => {"21"=>[7, 19, 31], "31"=>[19, 34, 49], "5"=>[8, 16, 25]},
      "OFarrell St  and  Powell St" => {"38"=>[9, 11, 16], "38L"=>[3, 7, 11]}
    }
  end

end
