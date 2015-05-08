module Webpack
  class Configuration
    include ActiveSupport::Configurable

    config_accessor(:path) {
      Rails.root.join('public', 'assets', 'manifest.json')
    }
  end
end
