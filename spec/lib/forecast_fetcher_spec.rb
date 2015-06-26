require 'spec_helper'
require 'webmock'
include WebMock::API

describe ForecastFetcher do
  let(:api_key) { 'FAKE-API-KEY' }

  let(:forecast_fetcher) { ForecastFetcher.new api_key }

  let(:sf_forecast_url) do
    'https://api.forecast.io/forecast/FAKE-API-KEY/37.781667,-122.404367?units=us'
  end

  let(:pa_forecast_url) do
    'https://api.forecast.io/forecast/FAKE-API-KEY/37.394555,-122.148039?units=us'
  end

  let(:nyc_forecast_url) do
    'https://api.forecast.io/forecast/FAKE-API-KEY/40.740673,-73.994808?units=us'
  end

  let(:london_forecast_url) do
    'https://api.forecast.io/forecast/FAKE-API-KEY/51.5072,0.1275?units=uk'
  end

  let(:toronto_forecast_url) do
    'https://api.forecast.io/forecast/FAKE-API-KEY/43.649932,-79.375756?units=si'
  end

  let(:boulder_forecast_url) do
    'https://api.forecast.io/forecast/FAKE-API-KEY/40.01499,-105.27055?units=us'
  end

  let(:denver_forecast_url) do
    'https://api.forecast.io/forecast/FAKE-API-KEY/39.7392,-104.9903?units=us'
  end

  before do
    stub_request(:get, nyc_forecast_url).to_return(:body => File.read('spec/fixtures/forecast/nyc.json'))
    stub_request(:get, pa_forecast_url).to_return(:body => File.read('spec/fixtures/forecast/palo-alto.json'))
    stub_request(:get, sf_forecast_url).to_return(:body => File.read('spec/fixtures/forecast/sf.json'))
    stub_request(:get, london_forecast_url).to_return(:body => File.read('spec/fixtures/forecast/london.json'))
    stub_request(:get, toronto_forecast_url).to_return(:body => File.read('spec/fixtures/forecast/toronto.json'))
    stub_request(:get, boulder_forecast_url).to_return(:body => File.read('spec/fixtures/forecast/boulder.json'))
    stub_request(:get, denver_forecast_url).to_return(:body => File.read('spec/fixtures/forecast/denver.json'))
  end

  it 'collects forecast data for each location' do
    expect(forecast_fetcher.data[:sf]).to eq({
      :current_temp=>"55°F",
      :current_icon=>"partly-cloudy-day",
      :current_desc=>"Mostly Cloudy",
      :apparent_temp=>"55°F",
      :later_desc=>"Partly cloudy later this evening.",
      :later_icon=>"partly-cloudy-day",
      :next_desc=>"Mostly cloudy for the hour.",
      :next_icon=>"partly-cloudy-day"
    })
    expect(forecast_fetcher.data[:pa]).to eq({
      :current_temp=>"66°F",
      :current_icon=>"partly-cloudy-day",
      :current_desc=>"Mostly Cloudy",
      :apparent_temp=>"66°F",
      :later_desc=>"Partly cloudy until this evening.",
      :later_icon=>"partly-cloudy-day",
      :next_desc=>"Mostly cloudy for the hour.",
      :next_icon=>"partly-cloudy-day"
    })
    expect(forecast_fetcher.data[:nyc]).to eq({
      :current_temp=>"55°F",
      :current_icon=>"partly-cloudy-day",
      :current_desc=>"Mostly Cloudy",
      :apparent_temp=>"55°F",
      :alternate_temp=>"13°C",
      :later_desc=>"Partly cloudy later this evening.",
      :later_icon=>"partly-cloudy-day",
      :next_desc=>"Mostly cloudy for the hour.",
      :next_icon=>"partly-cloudy-day"
    })
    expect(forecast_fetcher.data[:london]).to eq({
      :current_temp=>"14°C",
      :current_icon=>"partly-cloudy-day",
      :current_desc=>"Partly Cloudy",
      :apparent_temp=>"14°C",
      :later_desc=>"Partly cloudy throughout the day.",
      :later_icon=>"partly-cloudy-day",
      :next_desc=>"Partly cloudy for the hour.",
      :next_icon=>"partly-cloudy-day"
    })
    expect(forecast_fetcher.data[:to]).to eq({
      :current_temp=>"13°C",
      :current_icon=>"partly-cloudy-day",
      :current_desc=>"Mostly Cloudy",
      :apparent_temp=>"13°C",
      :later_desc=>"Partly cloudy later this evening.",
      :later_icon=>"partly-cloudy-day",
      :next_desc=>"Mostly cloudy for the hour.",
      :next_icon=>"partly-cloudy-day"
    })
    expect(forecast_fetcher.data[:boulder]).to eq({
        :current_temp=>"13°F",
        :apparent_temp=>"13°F",
        :current_icon=>"partly-cloudy-day",
        :current_desc=>"Mostly Cloudy",
        :later_desc=>"Partly cloudy later this evening.",
        :later_icon=>"partly-cloudy-day",
        :next_desc=>"Mostly cloudy for the hour.",
        :next_icon=>"partly-cloudy-day"
    })
    expect(forecast_fetcher.data[:denver]).to eq({
        :current_temp=>"13°F",
        :apparent_temp=>"13°F",
        :current_icon=>"partly-cloudy-day",
        :current_desc=>"Mostly Cloudy",
        :later_desc=>"Partly cloudy later this evening.",
        :later_icon=>"partly-cloudy-day",
        :next_desc=>"Mostly cloudy for the hour.",
        :next_icon=>"partly-cloudy-day"
    })
  end
end
