require 'spec_helper'
require 'webmock'
include WebMock::API

describe GoTrainStatusFetcher do
  describe 'initializtion' do
    before do
      stub_request(:get, described_class::URL).to_return(:body => File.read('spec/fixtures/go_train_status.aspx'))
    end

    it 'should grab a list of image links' do
      html = described_class.new().status_table
      expect(html).to eq(File.read('spec/fixtures/go_train_status_table.html').strip)
    end
  end
end
