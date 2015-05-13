module Webpack
  class Railtie < Rails::Railtie
    initializer 'load manifest class' do
      ActiveSupport.on_load :action_view do
        require 'webpack/asset_url_helper'
        include AssetUrlHelper
      end
    end
  end
end
