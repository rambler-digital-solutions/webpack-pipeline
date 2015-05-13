module Webpack
  module AssetUrlHelper
    extend ActiveSupport::Concern

    included do
      def compute_asset_path(source, options = {})
        webpack.asset_url(source) || super(source, options)
      end

      def webpack
        @webpack ||= Manifest.instance
      end
    end
  end
end
