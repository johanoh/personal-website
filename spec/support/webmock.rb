require 'webmock/rspec'

WebMock.disable_net_connect!(allow_localhost: true)

RSpec.configure do |config|
  config.before(:each) do
    stub_request(:get, %r{google.com}).to_return(status: 200, body: "", headers: {})
    stub_request(:get, %r{bing.com}).to_return(status: 200, body: "", headers: {})
    stub_request(:get, %r{search.yahoo.com}).to_return(status: 200, body: "", headers: {})
    stub_request(:get, %r{duckduckgo.com}).to_return(status: 200, body: "", headers: {})
  end
end
