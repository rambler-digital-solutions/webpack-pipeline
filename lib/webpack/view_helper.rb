require 'webpack/manifest'

module Webpack
  module ViewHelper
    def webpack_javascript_tag(chunk)
      path = webpack.javascripts[chunk.to_s]
      fail ArgumentError, "cant find chunk #{chunk}" unless path
      javascript_include_tag path
    end

    def webpack_stylesheet_tag(chunk = nil)
      path = webpack.stylesheets[chunk.to_s]
      fail ArgumentError, "cant find chunk #{chunk}" unless path
      stylesheet_link_tag path
    end

    protected

    def webpack
      @webpack ||= Manifest.instance
    end
  end
end
