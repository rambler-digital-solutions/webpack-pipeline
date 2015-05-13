module Webpack
  class Configuration
    include ActiveSupport::Configurable

    config_accessor(:path) {
      File.join('public', 'assets', 'manifest.json')
    }
  end
end
