module Webpack
  class Configuration
    include ActiveSupport::Configurable

    config_accessor(:path) {
      File.join('config', 'manifest.json')
    }
  end
end
