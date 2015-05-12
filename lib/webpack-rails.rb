require 'webpack/railtie'

module Webpack
  class Railtie < Rails::Railtie
    initializer 'load manifest class' do
      ActiveSupport.on_load :action_view do
        require 'webpack/view_helper'
        include ViewHelper
      end
    end
  end
end
