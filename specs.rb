require 'rack/test'
require 'rspec'

ENV['RACK_ENV'] = 'test'

require_relative 'index'

module RSpecMixin
  include Rack::Test::Methods
  def app() Sinatra::Application end
end

RSpec.configure { |c| c.include RSpecMixin }


# specs
describe 'items project' do
  # clean DB before each test
  before { DB[:items].truncate }

  describe 'get /' do
    it 'should allow accessing the home page' do
      get '/'
      expect(last_response).to be_ok
    end

    it 'should render with item' do
      DB[:items].insert(item: 'first item')
      get '/'
      expect(last_response).to match('<li>1. first item</li>')
    end

    it 'should render page with on items' do
      get '/'
      expect(last_response).to match('<div>No items</div>')
    end
  end
end