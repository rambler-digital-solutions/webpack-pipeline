ENV["RAILS_ENV"] = 'development'

require 'action_view'
require 'rails'

require 'simplecov'

module SimpleCov::Configuration
  def clean_filters
    @filters = []
  end
end

SimpleCov.configure do
  clean_filters
  load_adapter 'test_frameworks'
end

ENV["COVERAGE"] && SimpleCov.start do
  add_filter "/.rvm/"
end
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'rspec'
require 'webpack-pipeline'
require 'webpack/manifest'
require 'webpack/asset_url_helper'

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

RSpec.configure do |rspec|
  rspec.before :suite do
    Webpack::Manifest.configure do |config|
      config.path = File.join('spec', 'fixtures', 'manifest.json')
    end
  end
end
